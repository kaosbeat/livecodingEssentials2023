
 
 // Type some code on a new line (such as "osc().out()"), and press CTRL+shift+enter

// await loadScript("https://cdn.jsdelivr.net/gh/ojack/hydra-osc/lib/osc.min.js")
await loadScript("osc.min.js")

_osc = new OSC()
_osc.open()



/* example to receive osc */

_osc.on("*", (m) => { console.log(m.address, m.args)})

hue = 0
_osc.on("/hue", (m) => {
  //console.log(m)
  hue = m.args[0]/255
})

shape(4).color(-1, 1).hue(() => hue).out()
