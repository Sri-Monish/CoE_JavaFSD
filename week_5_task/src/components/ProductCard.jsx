import { useCart } from "../context/CartContext";

const ProductCard = ({ product }) => {
  const { dispatch } = useCart();
  return (
    <div className="border p-4 rounded-lg shadow-lg hover:scale-105 transition transform duration-200 ease-in-out bg-white">
      <img src={product.image} alt={product.name} className="w-full h-48 object-cover rounded-md" />
      <h3 className="font-bold text-lg mt-2 text-gray-800">{product.name}</h3>
      <p className="text-gray-700 font-semibold">₹{product.price}</p>
      <button
        className="bg-red-500 text-white px-4 py-2 mt-2 w-full rounded-lg hover:bg-green-600 transition"
        onClick={() => dispatch({ type: "ADD_TO_CART", payload: product })}
      >
        Add to Cart
      </button>
    </div>
  );
};
export default ProductCard;