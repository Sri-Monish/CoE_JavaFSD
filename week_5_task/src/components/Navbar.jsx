import { Link } from "react-router-dom";
import { useCart } from "../context/CartContext";

const Navbar = () => {
  const { state } = useCart();
  return (
    <nav className="bg-blue-600 p-4 flex justify-between text-white shadow-md fixed w-full top-0 z-10">
      <Link to="/" className="text-xl font-bold hover:text-gray-200 transition px-4">🛒 E-Shop</Link>
      <Link to="/cart" className="text-lg hover:text-gray-200 transition px-4">Cart ({state.cart.length})</Link>
    </nav>
  );
};
export default Navbar;
