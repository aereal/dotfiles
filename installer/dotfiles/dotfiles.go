package dotfiles

import (
	"os"
	"path/filepath"
)

func NewDotfilesInstaller(rootDir string, destDir string, skipper Skipper) *DotfilesInstaller {
	return &DotfilesInstaller{
		rootDir: rootDir,
		destDir: destDir,
		skipper: skipper,
	}
}

type DotfilesInstaller struct {
	rootDir string
	destDir string
	skipper Skipper
}

func (i *DotfilesInstaller) Install() error {
	srcs, err := collectConfigFiles(i.rootDir, i.skipper)
	if err != nil {
		return err
	}
	err = linkFiles(srcs, i.destDir)
	if err != nil {
		return err
	}
	return nil
}

func collectConfigFiles(root string, skipper Skipper) ([]string, error) {
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

type Skipper interface {
	Skip(path string) bool
}

func NewSkipper(paths []string) Skipper {
	mapping := skipMapping{}
	for _, p := range paths {
		mapping[p] = true
	}
	return mapping
}

type skipMapping map[string]bool

func (m skipMapping) Skip(path string) bool {
	return m[path]
}
