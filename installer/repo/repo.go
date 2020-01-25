package repo

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"path"
)

type GithubRepo struct {
	Owner string
	Name  string
}

func (r *GithubRepo) String() string {
	return r.Owner + "/" + r.Name
}

func (r *GithubRepo) URLForClone() string {
	return fmt.Sprintf("https://github.com/%s/%s", r.Owner, r.Name)
}

func Install(root string, repo *GithubRepo) (installedPath string, err error) {
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

func installRepo(repo *GithubRepo, dest string) error {
	log.Printf("try to install repository (%s) to %s", repo.URLForClone(), dest)
	cmd := exec.Command("git", "clone", "--no-progress", repo.URLForClone(), dest)
	if err := cmd.Run(); err != nil {
		return err
	}
	return nil
}
