// add hovered class to selected list item
let list = document.querySelectorAll(".navigation li");
const currentPage = window.location.pathname.split("/").pop();

function activeLink() {
  list.forEach((item) => {
    item.classList.remove("hovered");
  });
  this.classList.add("hovered");
}

list.forEach((item) => item.addEventListener("mouseover", activeLink));

// Menu Toggle
let toggle = document.querySelector(".toggle");
let navigation = document.querySelector(".navigation");
let main = document.querySelector(".main");

toggle.onclick = function () {
  navigation.classList.toggle("active");
  main.classList.toggle("active");
};

let medPlusBtn = document.getElementById("medPlus")
let testPlusBtn = document.getElementById("testPlus")


let medContainerHTML = document.getElementById("medication-info")
let testContainerHTML = document.getElementById("test-info")

medPlusBtn && medPlusBtn.addEventListener('click',addMedField)
testPlusBtn && testPlusBtn.addEventListener('click', addTestField)
function addMedField()
{
  let medContainer = document.getElementById("medication-info")

  medContainer.innerHTML += `<br>`+ medContainerHTML.innerHTML;
}

function addTestField()
{
  let testContainer = document.getElementById("test-info")
  testContainer.innerHTML += `<br>`+testContainerHTML.innerHTML;
}

