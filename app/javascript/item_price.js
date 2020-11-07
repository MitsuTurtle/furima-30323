window.addEventListener('load', function(){
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    // 価格
    const inputValue = priceInput.value;
    // 販売手数料（10%）
    addTaxPrice = document.getElementById("add-tax-price");
    addTaxPriceValue = Math.floor(inputValue * 0.1);
    addTaxPrice.innerHTML = addTaxPriceValue;
    // 販売利益
    profit = document.getElementById("profit");
    profit.innerHTML = inputValue - addTaxPriceValue;
  });
})