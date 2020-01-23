package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"
	"path"
	"path/filepath"
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
	flgs.Parse(argv[1:])

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
