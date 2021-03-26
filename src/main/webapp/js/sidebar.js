function sidebarCollapse() {
   if(document.getElementById("mySidebar").style.width == "250px"){
      document.getElementById("mySidebar").style.width = "0";
        document.getElementById("header").style.marginLeft = "0";
   } 
   else {
      document.getElementById("mySidebar").style.width = "250px";
      document.getElementById("header").style.marginLeft = "250px";
   }
}