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
  /*
   * I'm not sure whether we shouldn't rather use modify.
   * However when I save the file in Emacs, I get 2 modify
   * events and only one access event, so by using access
   * we save ourselves the hassle of running the code twice.
   *
   * The problem doesn't occur when I use the touch command.
   */
  if (kind === "access") {
    console.log(`~ Path ${paths[0]} has changed.`)
    await compile(paths[0])
  }
}
