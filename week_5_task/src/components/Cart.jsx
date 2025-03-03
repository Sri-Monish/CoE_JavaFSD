import { useCart } from "../context/CartContext";

const Cart = () => {
  const { state, dispatch } = useCart();

  return (
    <div>
      {state.cart.length === 0 ? (
        <p>Cart is empty</p>
      ) : (
        state.cart.map((item) => (
          <div key={item.id} className="flex justify-between p-2 border-b">
            <span>{item.name} - ${item.price}</span>
            <button
              className="bg-red-500 text-white px-2 py-1"
              onClick={() => dispatch({ type: "REMOVE_FROM_CART", payload: item.id })}
            >
              Remove
            </button>
          </div>
        ))
      )}
    </div>
  );
};

export default Cart;
