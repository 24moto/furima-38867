window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");

  const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 );
    
  const profit = document.getElementById("profit");
    profit.innerHTML = Math.floor(priceInput.value - Math.round(priceInput.value * 0.1 ));

});