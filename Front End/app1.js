// add hovered class to selected list item
let list = document.querySelectorAll(".navigation li");

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

let medContainer = document.getElementById("medication-info")
let testContainer = document.getElementById("test-info")

// console.log(medContainer)

medPlusBtn && medPlusBtn.addEventListener('click',addMedField)
testPlusBtn && testPlusBtn.addEventListener('click', addTestField)
function addMedField()
{
  medContainer.innerHTML += `<br>`+medContainer.innerHTML;
}

function addTestField()
{
  testContainer.innerHTML += `<br>`+testContainer.innerHTML;
}

