import { useCart } from "../context/CartContext";

const CartPage = () => {
  const { state, dispatch } = useCart();
  const totalPrice = state.cart.reduce((total, item) => total + item.price * item.quantity, 0);

  const handleCheckout = () => {
    if (state.cart.length === 0) {
      alert("Your cart is empty! Add items before checking out.");
      return;
    }
    alert("Checkout successful! Thank you for your purchase.");
    dispatch({ type: "CLEAR_CART" });
  };

  return (
    <div className="p-6 mt-20 bg-gradient-to-br from-purple-400 to-pink-500 min-h-screen rounded-lg shadow-lg">
      <h2 className="text-3xl font-bold mb-6 text-white text-center">Shopping Cart</h2>
      {state.cart.length === 0 ? (
        <p className="text-white text-lg text-center">Your cart is empty.</p>
      ) : (
        <>
          {state.cart.map((item) => (
            <div key={item.id} className="flex justify-between items-center p-4 border-b bg-white shadow-md rounded-md mb-4">
              <img src={item.image} alt={item.name} className="w-16 h-16 object-cover rounded-md" />
              <span className="text-gray-800 font-semibold">{item.name} - ₹{item.price * item.quantity}</span>
              <input
                type="number"
                min="1"
                value={item.quantity}
                onChange={(e) =>
                  dispatch({ type: "UPDATE_QUANTITY", payload: { id: item.id, quantity: Number(e.target.value) } })
                }
                className="w-16 p-1 border rounded text-center"
              />
              <button
                className="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600 transition"
                onClick={() => dispatch({ type: "REMOVE_FROM_CART", payload: item.id })}
              >
                Remove
              </button>
            </div>
          ))}
          <div className="text-right text-2xl font-bold mt-6 text-white">Total Price: ₹{totalPrice}</div>
          <button
            className="bg-yellow-500 text-white px-6 py-3 rounded-lg w-full mt-6 hover:bg-yellow-600 transition text-lg font-semibold"
            onClick={handleCheckout}
          >
            Checkout
          </button>
        </>
      )}
    </div>
  );
};
export default CartPage;