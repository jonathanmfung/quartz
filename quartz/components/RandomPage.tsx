import {resolveRelative,} from "../util/path"

interface Options {
  favouriteNumber: number
}

const defaultOptions: Options = {
  favouriteNumber: 42,
}

export default ((userOptions?: Options) => {
  const opts = { ...userOptions, ...defaultOptions }

  function getRandom (list) {
    const idx = Math.floor((Math.random() * list.length))
    return list[idx];
  }

  // TODO: I have no idea how to get allFiles at runtime.
  //       I could scrape Explorer Component.
  function RandomPage(props: QuartzComponentProps) {
    let ran_file = getRandom(props.allFiles)
    while (ran_file.slug == props.fileData.slug) {
      ran_file = getRandom(props.allFiles)
    }

    const nav_ran = `window.location.assign('${resolveRelative(props.fileData.slug!, ran_file.slug!)}')`
    const button =
    	  <button id="random-btn" onClick={nav_ran}>
    	    Pseudorandom Page
	  </button>

    return button
  }

  return RandomPage
}) satisfies QuartzComponentConstructor