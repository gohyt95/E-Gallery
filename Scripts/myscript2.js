const inputsNumber = document.querySelectorAll(".inputNumber");

inputsNumber.forEach(inputBox => {
    inputBox.childNodes[1].addEventListener("click", (e) => {
        const numberInput = e.target.parentNode.childNodes[3];
        numberInput.value = parseInt(numberInput.value) - 1;
    });

    inputBox.childNodes[5].addEventListener("click", (e) => {
        const numberInput = e.target.parentNode.childNodes[3];
        numberInput.value = parseInt(numberInput.value) + 1;
    });

    inputBox.childNodes[3].addEventListener("change", (e) => {
        if (isNaN(e.target.value) || parseInt(e.target.value) < 1 || e.target.value == "") {
            e.target.value = 1;
        }
    });
});