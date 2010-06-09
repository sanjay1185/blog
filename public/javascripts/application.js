var Slides = new Array();
function CacheImage(ImageSource) { 

var ImageObject = new Image();
   ImageObject.src = ImageSource;
   return ImageObject;
}

function ShowSlide(Direction) {
   if (SlideReady) {
      NextSlide = CurrentSlide + Direction;
      document.SlideShow.Previous.disabled = (NextSlide == 0);
      document.SlideShow.Next.disabled = (NextSlide ==(Slides.length-1));
 if ((NextSlide >= 0) && (NextSlide < Slides.length)) {
            document.images['Screen'].src = Slides[NextSlide].src;
            CurrentSlide = NextSlide++;
            Message = 'Picture ' + (CurrentSlide+1) + ' of ' +
Slides.length;
            self.defaultStatus = Message;
            if (Direction == 1) CacheNextSlide();
      }
      return true;
   }
}

function Download() {
   if (Slides[NextSlide].complete) {
      SlideReady = true;
      self.defaultStatus = Message;
   }
   else setTimeout("Download()", 100); 
   return true;
}

function CacheNextSlide() {
   if ((NextSlide < Slides.length) && (typeof Slides[NextSlide] ==
'string'))
{ 
      SlideReady = false;
      self.defaultStatus = 'Downloading next picture...';
      Slides[NextSlide] = CacheImage(Slides[NextSlide]);
      Download();
   }
   return true;
}

function StartSlideShow(images) {

 Slides=images
   CurrentSlide = -1;
   Slides[0] = CacheImage(Slides[0]);
   SlideReady = true;
   ShowSlide(1,Slides);
}

function noPicture(ele){

  if(ele.checked==true){
    document.getElementById('picture_display').style.display="none";
    document.getElementById('togglebutton').style.display="none";
  }
  else{
    document.getElementById('picture_display').style.display="block";
    document.getElementById('togglebutton').style.display="block";
  }
}