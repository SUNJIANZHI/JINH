# JINH

JINH is a pure functional actuarial language based on Haskell.

JINH is decrement-driven and abstracts some useful high-order function to faciliate the modeling.
JINH supports most of the traditional life products, like whole life, term life, endowment. 
Reserve methods are flexible in JINH, both Gross Premium Reserve(GPV) and Net Premium Reserve(NPV) could be applied in JINH.
Unlimited decrements could be easily applied with the templates offered in Morbidity.hs.


A matrix exponential approach is supported to calculated more complicated state model. A simple proof is attached below.

<a href="https://www.codecogs.com/eqnedit.php?latex=e^{At}&space;=&space;\sum&space;{\frac&space;{At^k}&space;{k!}}&space;=&space;\sum&space;{\frac&space;{tA^k}&space;{k!}}&space;=&space;e^{tA}&space;=&space;B&space;e^{Dt}&space;B^{-1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?e^{At}&space;=&space;\sum&space;{\frac&space;{At^k}&space;{k!}}&space;=&space;\sum&space;{\frac&space;{tA^k}&space;{k!}}&space;=&space;e^{tA}&space;=&space;B&space;e^{Dt}&space;B^{-1}" title="e^{At} = \sum {\frac {At^k} {k!}} = \sum {\frac {tA^k} {k!}} = e^{tA} = B e^{Dt} B^{-1}" /></a> where (B,D) represents the diagonalizable matrix.

The modeling process in JINH is similar to what actuaries model in Excel, MoSes and Prophet, while with better support in function abstraction using high-order function. A parallel Excel model is also offered to help you quickly pick up JINH.

## Useful Utils for modeling
High order function like scan and fold could be useful when cash flow is projected based on the figure at previous month. We tailor made a custom scan which scans more than 1 element before the valuation month. Generic scan could facilitate the calculation like IBNR.

## Getting Started

Install the packages listed below

```
clock-0.7.2
exceptions-0.10.0
hmatrix-0.19.0.0
cassava-0.5.1.0
Formatting-6.3.6
```
Please find the term life product with surrender decrement, morbidity decrement and mortality decrement under main.hs

```
stack ghci main.hs
```





## Contributing

Welcome to submit pull request for us.


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Todo
This is a half-year undergraduate final year project. Due to the time limit and my experience in the actuarial field, limited function is applied. More functions will be added when gaining more experience in both actuarial industry and Haskell.

* Extend to library to support valuation regulation like IFRS17, USGAAP, CROSS2.

* Create a GUI to facilitate the actuaries with no Haskell background.

* Better support state model.
