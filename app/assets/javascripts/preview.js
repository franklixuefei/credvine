// function DrawImage(ImgD, preW, preH){
   // var image=new Image();
   // image.src=ImgD.src;
   // if (image.width>0 && image.height>0) {
      // flag=true;
      // if (image.width/image.height>= preW/preH) {
         // if (image.width>preW) {  
            // ImgD.width=preW;
            // ImgD.height=(image.height*preW)/image.width;
         // } else {
            // ImgD.width=image.width;  
            // ImgD.height=image.height;
         // }
         // ImgD.alt=image.width+"×"+image.height;
      // }
      // else {
         // if (image.height>preH) {  
            // ImgD.height=preH;
            // ImgD.width=(image.width*preH)/image.height;     
         // } else {
            // ImgD.width=image.width;
            // ImgD.height=image.height;
         // }
         // ImgD.alt=image.width+"×"+image.height;
      // } 
   // }
   // } 
// 
// function FileChange(Value) {
   // flag=false;
   // document.getElementById("uploadimage1").width=10;
   // document.getElementById("uploadimage1").height=10;
   // document.getElementById("uploadimage1").alt="";
   // document.getElementById("uploadimage1").src=Value;
   // document.getElementById("uploadimage2").width=10;
   // document.getElementById("uploadimage2").height=10;
   // document.getElementById("uploadimage2").alt="";
   // document.getElementById("uploadimage2").src=Value;
// }


 function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object

    // Loop through the FileList and render image files as thumbnails.
    for (var i = 0, f; f = files[i]; i++) {

      // Only process image files.
      if (!f.type.match('image.*')) {
        continue;
      }

      var reader = new FileReader();

      // Closure to capture the file information.
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
       document.getElementById('p1').src=e.target.result;
       document.getElementById('p2').src=e.target.result;

        };
      })(f);

      // Read in the image file as a data URL.
      reader.readAsDataURL(f);
    }
  }

  document.getElementById('smb_logo').addEventListener('change', handleFileSelect, false);
