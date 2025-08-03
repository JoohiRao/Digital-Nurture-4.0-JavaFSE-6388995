import React, { useState } from 'react';

function CurrencyConverter() {
  const [amount, setAmount] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    const rupeeValue = parseFloat(amount) * 80; // 1 Euro ≈ 80 INR
    alert(`Converting to Euro Amount is ${rupeeValue}`);
  };

  return (
    <div style={{ marginTop: '40px' }}>
      <h2 style={{ color: 'green' }}>Currency Convertor!!!</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Amount: </label>
          <input
            type="number"
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
            required
          />
        </div>
        <div>
          <label>Currency: </label>
          <input value="Euro" disabled />
        </div>
        <button type="submit">Submit</button>
      </form>
    </div>
  );
}

export default CurrencyConverter;
