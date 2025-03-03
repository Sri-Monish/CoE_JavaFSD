import ProductCard from "../components/ProductCard";
import headphonesImg from "../assets/headphone.webp";
import laptopImg from "../assets/laptop.webp";
import twsImg from "../assets/tws.webp";
import mobileImg from "../assets/mobile.webp";
import monitorImg from "../assets/monitor.webp";
import watchImg from "../assets/watch.webp";
import gcImg from "../assets/GameCon.webp";
import kbImg from "../assets/keyb.webp";
const products = [
    { 
      id: 1, 
      name: "Laptop", 
      price: 55000, 
      image: laptopImg
    },
    { 
      id: 2, 
      name: "Smartphone", 
      price: 25000, 
      image: mobileImg
    },
    { 
        id: 3, 
        name: "Headphones", 
        price: 2000, 
        image: headphonesImg
      },
      { 
        id: 4, 
        name: "Smartwatch", 
        price: 5000, 
        image: watchImg
      },
      { 
        id: 5, 
        name: "Gaming Console", 
        price: 45000, 
        image: gcImg
      },
      { 
        id: 6, 
        name: "Wireless Earbuds", 
        price: 3000, 
        image: twsImg
      },
      { 
        id: 7, 
        name: "Mechanical Keyboard", 
        price: 7000, 
        image: kbImg
      },
      { 
        id: 8, 
        name: "Monitor", 
        price: 15000, 
        image: monitorImg
      }
    ];
  
  
    const Home = () => (
      <div className="p-6 mt-20 bg-gradient-to-br from-blue-400 to-green-500 min-h-screen rounded-lg shadow-lg">
    <h1 className="text-4xl font-bold text-center mb-8 text-white">Welcome to E-Shop</h1>
    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
          {products.map((product) => <ProductCard key={product.id} product={product} />)}
        </div>
      </div>
    );
    export default Home;