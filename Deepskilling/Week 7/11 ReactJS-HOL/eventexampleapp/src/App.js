import React, { useState } from 'react';
import CurrencyConverter from './CurrencyConverter';

function App() {
  const [counter, setCounter] = useState(0);

  const increment = () => {
    setCounter(prev => prev + 1);
    sayHello();
  };

  const decrement = () => setCounter(prev => prev - 1);

  const sayHello = () => {
    console.log("Hello! This is a static message.");
  };

  const sayWelcome = (message) => {
    alert(message);
  };

  const handleClick = (e) => {
    alert("I was clicked");
  };

  return (
    <div style={{ padding: "20px" }}>
      <h2>Event Examples App</h2>

      <div style={{ display: "flex", flexDirection: "column", alignItems: "flex-start", gap: "10px", marginBottom: "20px" }}>
  <p>Counter: {counter}</p>
  <button onClick={increment}>Increment</button>
  <button onClick={decrement}>Decrement</button>
</div>

     
      <div style={{ marginTop: "10px" }}>
        <button onClick={() => sayWelcome("Welcome!")}>Say Welcome</button>
      </div>

   
      <div style={{ marginTop: "10px" }}>
        <button onClick={handleClick}>Click Me</button>
      </div>

     
      <CurrencyConverter />
    </div>
  );
}

export default App;
