// Use the watch function from .profile.zsh to run this.

const paths = ["src/App.org"]

async function compile(path: string) {
  await compileOrgToElm(path)
  await compileElm(path.replace(/\.org$/, '.elm'))
}

function compileOrgToElm(path: string) {
  const command = [Deno.cwd(), "bin/compile.el"].join("/")
  return Deno.run({cmd: ["emacs", "--script", command, path]}).status()
}

function compileElm(path: string) {
  return Deno.run({cmd: ["elm", "make", path]}).status()
}

const watcher = Deno.watchFs(paths)
console.log(`~ Watching ${paths}`)
for await (const { kind, paths } of watcher) {
  if (kind === "modify") {
    console.log(`~ Path ${paths[0]} has changed.`)
    await compile(paths[0])
  }
}
