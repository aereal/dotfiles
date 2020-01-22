package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"
	"path"
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
	if err := assumeInstalledRepo(root, dotfilesRepo); err != nil {
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

func assumeInstalledRepo(root string, repo *githubRepo) error {
	repoFullPath := path.Join(root, "src", "github.com", repo.Owner, repo.Name)
	_, err := os.Stat(repoFullPath)
	if os.IsNotExist(err) {
		return installRepo(repo, repoFullPath)
	}
	if err != nil {
		return err
	}
	return nil
}

func installRepo(repo *githubRepo, dest string) error {
	log.Printf("try to install repository (%s) to %s", repo.URLForClone(), dest)
	cmd := exec.Command("git", "clone", "--no-progress", repo.URLForClone(), dest)
	if err := cmd.Run(); err != nil {
		return err
	}
	return nil
}
