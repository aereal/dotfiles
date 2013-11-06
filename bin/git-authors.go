package main

// original: https://github.com/dann/dotfiles/blob/master/devbin/git-authors

import (
  "fmt"
  "log"
  "os/exec"
  "regexp"
  "sort"
  "strconv"
  "strings"
)

type Commit struct {
  Author string
  Commits int
  Insertions int
  Deletions int
}
func (c Commit) Ratio(total int) float64 {
  return float64(c.Commits) / float64(total) * 100.0
}

type CommitsSummary []*Commit

func (cs CommitsSummary) Len() int {
  return len(cs)
}

func (cs CommitsSummary) Swap(i, j int) {
  cs[i], cs[j] = cs[j], cs[i]
}

type ByCommitsCount struct {
  CommitsSummary
}

func (bcc ByCommitsCount) Less(i, j int) bool {
  return bcc.CommitsSummary[i].Commits < bcc.CommitsSummary[j].Commits
}

func String2Int(s string) int {
  var (
    i int64
    e error
  )
  if i, e = strconv.ParseInt(s, 0, 0); e != nil {
    log.Fatal(e)
    return -1
  }
  return int(i)
}

func CreateCommit(author string, commits int, ins int, del int) *Commit {
  c := new(Commit)
  c.Author = author
  c.Commits = commits
  c.Insertions = ins
  c.Deletions = del
  return c
}

func main() {
  out, err := exec.Command("git", "--no-pager", "log", "--format=%H %aN <%aE>", "--no-merges", "--shortstat").Output()
  if err != nil {
    log.Fatal(err)
  }

  commitPattern := regexp.MustCompile(`^([0-9a-f]{40}) (.*)$`)
  statsPattern  := regexp.MustCompile(`(\d+) insert.* (\d+) delet*`)

  var currentAuthor string
  commitCounts := map[string]int{}
  inserts := map[string]int{}
  deletes := map[string]int{}
  totalCommits := 0
  for _, l := range(strings.Split(string(out), "\n")) {
    if commitPattern.MatchString(l) {
      totalCommits += 1
      m := commitPattern.FindStringSubmatch(l)
      if len(m) == 0 { continue }
      currentAuthor = m[2]
    } else if statsPattern.MatchString(l) {
      m := statsPattern.FindStringSubmatch(l)
      if len(m) == 0 { continue }
      ins := String2Int(m[1])
      del := String2Int(m[2])
      commitCounts[currentAuthor] += 1
      inserts[currentAuthor] += ins
      deletes[currentAuthor] += del
    }
  }

  var commits CommitsSummary
  for author, commitCount := range(commitCounts) {
    c := CreateCommit(author, commitCount, inserts[author], deletes[author])
    commits = append(commits, c)
  }
  sort.Sort(sort.Reverse(ByCommitsCount{commits}))

  fmt.Printf("%10s %10s %10s %10s\n", "%", "commits", "+++", "---")
  for _, c := range(commits) {
    fmt.Printf("%9.2f%% %10d %10d %10d  %s\n",
      c.Ratio(totalCommits),
      c.Commits,
      c.Insertions,
      c.Deletions,
      c.Author)
  }
}
