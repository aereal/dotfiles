package main

import (
	"context"
	"flag"
	"io"
	"log"
	"os"
	"os/exec"
	"path"
	"strings"

	"github.com/aereal/dotfiles/installer/dotfiles"
	"github.com/aereal/dotfiles/installer/repo"
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

	dotfilesRepo := &repo.GithubRepo{Owner: "aereal", Name: "dotfiles"}
	repoFullPath, err := repo.Install(root, dotfilesRepo)
	if err != nil {
		return err
	}

	homeDir, err := os.UserHomeDir()
	if err != nil {
		return err
	}

	skipper := dotfiles.NewSkipper([]string{
		"test",
		".dotfiles.ignore",
		".config",
		"README.md",
		"cmd",
		"colors",
		"osx",
		".gitmodules",
		".gitignore",
		".git",
		".travis.yml",
		"Rakefile",
		"brew.bash",
	})
	di := dotfiles.NewDotfilesInstaller(repoFullPath, homeDir, skipper)
	if err := di.Install(); err != nil {
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
