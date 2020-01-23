package main

import (
	"context"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"strings"

	"golang.org/x/sync/errgroup"
)

func main() {
	if err := run(os.Args); err != nil {
		log.Printf("! %s", err)
		os.Exit(1)
	}
}

func run(argv []string) error {
	name := path.Base(argv[0])
	flgs := flag.NewFlagSet(name, flag.ContinueOnError)
	var (
		root string
	)
	flgs.StringVar(&root, "root", os.ExpandEnv("$HOME/.ghq"), "GHQ_ROOT")
	err := flgs.Parse(argv[1:])
	if err == flag.ErrHelp {
		return nil
	}

	dotfilesRepo := &githubRepo{Owner: "aereal", Name: "dotfiles"}
	repoFullPath, err := assumeInstalledRepo(root, dotfilesRepo)
	if err != nil {
		return err
	}

	homeDir, err := os.UserHomeDir()
	if err != nil {
		return err
	}

	toSkip := skipMapping{
		"test":             true,
		".dotfiles.ignore": true,
		".config":          true,
		"README.md":        true,
		"cmd":              true,
		"colors":           true,
		"osx":              true,
		".gitmodules":      true,
		".gitignore":       true,
		".git":             true,
		".travis.yml":      true,
		"Rakefile":         true,
		"brew.bash":        true,
	}
	srcs, err := collectConfigFiles(repoFullPath, toSkip)
	if err != nil {
		return err
	}
	err = linkFiles(srcs, homeDir)
	if err != nil {
		return err
	}

	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	installer := &homebrewInstall{
		brewCommand: "brew",
		formulae: []*formula{
			newFormula("awscli"),
			newFormula("bat"),
			newFormula("coreutils"),
			newFormula("direnv"),
			newFormula("docker-completion"),
			newFormula("docker-compose-completion"),
			newFormula("envchain"),
			newFormula("exa"),
			newFormula("git"),
			newFormula("go"),
			newFormula("hub"),
			newFormula("jq"),
			newFormula("mysql-client"),
			newFormula("neovim"),
			newFormula("node"),
			newFormula("node@10"),
			newFormula("node@12"),
			newFormula("peco"),
			newFormula("proctools"),
			newFormula("pstree"),
			newFormula("python"),
			newFormula("readline"),
			newFormula("reattach-to-user-namespace"),
			newFormula("ripgrep"),
			newFormula("ruby"),
			newFormula("sshuttle"),
			newFormula("terraform"),
			newFormula("tig"),
			newFormula("tmux"),
			newFormula("tree"),
			newFormula("yarn"),
			newFormula("zsh"),
			newFormula("zsh-completions"),
			newFormula("zsh-history-substring-search"),
			newFormula("zsh-syntax-highlighting"),
		},
		outStream:   os.Stdout,
		errorStream: os.Stderr,
	}
	if err := installer.run(ctx); err != nil {
		return err
	}

	return nil
}

type githubRepo struct {
	Owner string
	Name  string
}

func (r *githubRepo) String() string {
	return r.Owner + "/" + r.Name
}

func (r *githubRepo) URLForClone() string {
	return fmt.Sprintf("https://github.com/%s/%s", r.Owner, r.Name)
}

func assumeInstalledRepo(root string, repo *githubRepo) (installedPath string, err error) {
	installedPath = path.Join(root, "src", "github.com", repo.Owner, repo.Name)
	_, err = os.Stat(installedPath)
	if os.IsNotExist(err) {
		err = installRepo(repo, installedPath)
		return
	}
	if err != nil {
		return
	}
	return
}

func installRepo(repo *githubRepo, dest string) error {
	log.Printf("try to install repository (%s) to %s", repo.URLForClone(), dest)
	cmd := exec.Command("git", "clone", "--no-progress", repo.URLForClone(), dest)
	if err := cmd.Run(); err != nil {
		return err
	}
	return nil
}

func collectConfigFiles(root string, skipper skipper) ([]string, error) {
	srcs := []string{}
	matches, err := filepath.Glob("*")
	if err != nil {
		return nil, err
	}
	for _, base := range matches {
		if skipper.Skip(base) {
			continue
		}
		srcs = append(srcs, filepath.Join(root, base))
	}
	return srcs, nil
}

func linkFiles(srcs []string, destDir string) error {
	for _, src := range srcs {
		dest := filepath.Join(destDir, filepath.Base(src))
		err := linkFile(src, dest)
		if err != nil {
			return err
		}
	}
	return nil
}

func linkFile(src string, dest string) error {
	err := os.Symlink(src, dest)
	if os.IsExist(err) {
		return nil
	}
	if err != nil {
		return err
	}
	return nil
}

func isSymlink(mode os.FileMode) bool {
	return mode&os.ModeSymlink != 0
}

type skipper interface {
	Skip(path string) bool
}

type skipMapping map[string]bool

func (m skipMapping) Skip(path string) bool {
	return m[path]
}

type homebrewInstall struct {
	brewCommand string
	formulae    []*formula
	outStream   io.Writer
	errorStream io.Writer
}

func (i *homebrewInstall) run(ctx context.Context) error {
	var eg *errgroup.Group
	eg, ctx = errgroup.WithContext(ctx)

	for _, cmd := range i.installCommand(ctx) {
		eg.Go(func() error {
			log.Printf("run %s", strings.Join(cmd.Args, " "))
			cmd.Stdout = i.outStream
			cmd.Stderr = i.errorStream
			return cmd.Run()
		})
	}

	return eg.Wait()
}

func (i *homebrewInstall) installCommand(ctx context.Context) []*exec.Cmd {
	cmds := []*exec.Cmd{}
	if len(i.formulae) == 0 {
		return cmds
	}

	wholeInstallCmd := exec.CommandContext(ctx, i.brewCommand, "install")
	for _, f := range i.formulae {
		if f.hasOptions() {
			cmd := f.command(ctx, i.brewCommand)
			cmds = append(cmds, cmd)
		} else {
			wholeInstallCmd.Args = append(wholeInstallCmd.Args, f.name)
		}
	}
	cmds = append(cmds, wholeInstallCmd)
	return cmds
}

type formula struct {
	name    string
	options []string
}

func newFormula(name string, options ...string) *formula {
	return &formula{
		name:    name,
		options: options,
	}
}

func (f *formula) hasOptions() bool {
	return len(f.options) > 0
}

func (f *formula) command(ctx context.Context, brew string) *exec.Cmd {
	cmd := exec.CommandContext(ctx, brew, "install")
	for _, opt := range f.options {
		cmd.Args = append(cmd.Args, opt)
	}
	cmd.Args = append(cmd.Args, f.name)
	return cmd
}
