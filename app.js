const express = require('express');
const path = require('path');
const bodyparser = require('body-parser');

const app = express();

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

var username = "admin";

const users = [
    { 
        username: 'admin', 
        password: 'admin123' 
    },
    { 
        username: 'user', 
        password: 'user123' 
    }
  ];

var products = [
    { 
        name: 'Laptop', 
        id: '102', 
        price: 35000,
        category: 'PC',
        manu_date: '2023-11-30',
        exp_date: '2027-11-30'
    },
    { 
        name: 'Laptop', 
        id: '101', 
        price: 55000,
        category: 'PC',
        manu_date: '2024-11-30',
        exp_date: '2028-11-30'
    },
    { 
        name: 'Mobile', 
        id: '201', 
        price: 15000,
        category: 'Phone',
        manu_date: '2024-11-30',
        exp_date: '2030-11-30'
    },
    { 
        name: 'TV', 
        id: '301', 
        price: 25000,
        category: 'Electronics',
        manu_date: '2024-11-30',
        exp_date: '2029-11-30'
    },
];


app.get('/',(req, res)=>{
    res.render('index');
});

app.get('/login',(req, res)=>{
    res.render('login');
});

// Middleware to parse form data
app.use(bodyparser.urlencoded({ extended: true }));

app.post('/validate', (req, res) => {
    var { username, password } = req.body;

    var user = users.find(u=>u.username === username && u.password === password)

    if (user) {
        // res.redirect('/products'); 
        res.render('products', { username: user.username, products: products, prods: []});
        // res.end('');
        // res.redirect('/products');
        // res.render('products', { username: user.username, products });
    } else {
        res.render('login', { error: 'Invalid Credentials' });
    }
});


app.get('/products',(req, res)=>{
    res.render('products', {products: products, prods:[]});
});


app.post('/addprod', (req, res) => {
    const productname = req.body.productName;
    const productId = req.body.productId;
    const productprice = req.body.productPrice;
    const productCategory = req.body.productCategory;
    const productManufDate = req.body.productManufDate;
    const productExpDate = req.body.productExpDate;

    let newProduct = { name: `${productname}`, id: `${productId}`, price: `${productprice}`, category: `${productCategory}`, manu_date: `${productManufDate}`, exp_date: `${productExpDate}`};

    products.push(newProduct);
    res.render('products', { username: username, products: products, prods: []});
    // res.redirect('/products', )
    // res.end();
    // console.log(products);
    // res.render('products', {products: products});
});

app.post('/searchprod', (req, res) => {
    var searchName = req.body.searchName;
    var searchCategory = req.body.searchCategory;
    // var { username, password } = req.body;
    const prods = products.filter(prod => prod.name === searchName || prod.category === searchCategory);
    // const prodsCat = products.find(prod => prod.category === searchCategory);
    // console.log(prodsName);
    // console.log(prodsCat);
    // const searchItems = [];
    // searchItems.push(prodsName, prodsCat);
    
    // // Add the new product to the array
    // products.push(newProduct);
    // res.redirect('/products')
    // // res.end();
    // // console.log(products);
    res.render('products', {products: products, prods: prods});
});


app.listen(3030, ()=>{
    console.log("Server started on ....");
    console.log("http://localhost:3030");    
})