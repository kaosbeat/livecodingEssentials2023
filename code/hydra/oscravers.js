 
 // Type some code on a new line (such as "osc().out()"), and press CTRL+shift+enter

// await loadScript("https://cdn.jsdelivr.net/gh/ojack/hydra-osc/lib/osc.min.js")
await loadScript("osc.min.js")
await loadScript("images.js")

a.show()

_osc = new OSC()
_osc.open()
// _osc.on("*", (m) => { console.log(m.address, m.args)})
hue = 0
img = cyborg
seed = 16777215
shp = 5

_osc.on("/hue", (m) => {
  //console.log(m)
  hue = m.args[0]/255
  shp = Math.floor(Math.random()*5)+3
})

_osc.on("/hydra", (m) => {
  hycmd = m.args[0]
  switch (hycmd){
    case 'imgset':
      imgset =  m.args[1];
      console.log("setting set: ",imgset);
      if (imgset == "cyborg") { img = cyborg; }
      else if (imgset == "masks") { img = masks; }
      else if (imgset == "frau") { img = frau; }
      else { img = dflt; }
      break;
    case 'newimg':
  	  index =  Math.floor((Math.abs(Math.sin(m.args[2]) * seed)))%img.length;
      curimg = "img/" + img[index];
  	  s0.initImage(curimg);
      break;
    case 'preset':
      preset =  m.args[1];
      console.log("setting preset", preset);
      if (preset == "strobe") {
      	render(o2);
      } else {
      	render(o3);
      }
      break;
    default:
      console.log(m)
  }
//   console.log("index = ", index);
//   console.log("curimg = ", curimg);
})


// // default

osc(() => (a.fft[1]*0)+2).modulate(src(s0),1).out(o1)


shape(() => shp).color(-1, 1).hue(() => hue).out()

src(o0).blend(o1).out(o2)


bpm = 252
osc(2,0.5).modulate(noise()).color(()=>a.fft[0]*2,0,0)
  .layer(osc().mask(shape(5,[0.45, 0.35,0.40],0.3).scale(1.5).rotate(1,0.5)))
  .out(o3)

render(o2);

