// Use the watch function from .profile.zsh to run this.

// FIXME: This currently fails.
// Check out https://deno.land/std@0.98.0/fs
/* import { expandGlob } from "https://deno.land/std@0.98.0/fs/mod.ts" */

/* const paths = expandGlob('src/*.org') */
const entryPoint = "src/App.elm"
const paths = ["src/App.org", "src/Post.org"]

async function compile(path: string) {
  await compileOrgToElm(path)
  await compileTheApp()
}

function compileOrgToElm(path: string) {
  const command = [Deno.cwd(), "bin/compile.el"].join("/")
  return Deno.run({cmd: ["emacs", "--script", command, path]}).status()
}

function compileTheApp() {
  return Deno.run({cmd: ["elm", "make", entryPoint]}).status()
}

const watcher = Deno.watchFs(paths)
console.log(`~ Watching ${paths.join(', ')}`)
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
