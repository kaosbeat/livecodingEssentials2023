 // script that changes parameters on OSC
 // script will also load images from URls in Array see images.js
 
 // Type some code on a new line (such as "osc().out()"), and press CTRL+shift+enter

// await loadScript("https://cdn.jsdelivr.net/gh/ojack/hydra-osc/lib/osc.min.js")
await loadScript("osc.min.js")
await loadScript("images.js")



_osc = new OSC()
_osc.open()
// _osc.on("*", (m) => { console.log(m.address, m.args)})
hue = 0
img = masks
seed = 16777215


_osc.on("/hue", (m) => {
  //console.log(m)
  hue = m.args[0]/255
  shp = Math.floor(Math.random()*5)+3
})

_osc.on("/newimg", (m) => {
  index =  Math.floor((Math.abs(Math.sin(m.args[0]) * seed)))%img.length;
//   console.log("index = ", index);
  curimg = "img/" + img[index]
//   console.log("curimg = ", curimg);
  s0.initImage(curimg);
  
})


// default

osc(6).modulate(src(s0),1).out(o1)


shape(() => shp).color(-1, 1).hue(() => hue).out()

src(o0).diff(o1).out(o2)
render(o2)
