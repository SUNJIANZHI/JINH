# JINH

JINH is a pure functional actuarial language based on Haskell.

JINH is decrement-driven and abstracts useful high-order functions to faciliate the modeling.
JINH supports most of the traditional life products, like whole life, term life, endowment, etc.
Reserve methods are flexible in JINH, both Gross Premium Reserve (GPV) and Net Premium Reserve (NPV) can be applied in JINH.
Unlimited decrements can be easily applied with the templates offered in Morbidity.hs.



A matrix exponential approach is supported for calculating more complicated state models. A simple proof is below.

<a href="https://www.codecogs.com/eqnedit.php?latex=e^{At}&space;=&space;\sum&space;{\frac&space;{At^k}&space;{k!}}&space;=&space;\sum&space;{\frac&space;{tA^k}&space;{k!}}&space;=&space;e^{tA}&space;=&space;B&space;e^{Dt}&space;B^{-1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?e^{At}&space;=&space;\sum&space;{\frac&space;{At^k}&space;{k!}}&space;=&space;\sum&space;{\frac&space;{tA^k}&space;{k!}}&space;=&space;e^{tA}&space;=&space;B&space;e^{Dt}&space;B^{-1}" title="e^{At} = \sum {\frac {At^k} {k!}} = \sum {\frac {tA^k} {k!}} = e^{tA} = B e^{Dt} B^{-1}" /></a> where (B,D) represents the diagonalizable matrix.

The modeling process in JINH is similar to actuarial modeling in Excel, MoSes, and Prophet, and features better support for function abstraction with high-order functions. A parallel Excel model is offered to help you quickly pick up JINH.

## Useful Utils for modeling

High order functions like `scan` and `fold` could be useful when the cash flow is projected based on the figure of the previous month. We tailor-made a custom `scan` which scans multiple elements before the valuation month. Generic `scan` facilitates the calculation like IBNR.

## Getting Started

Install the packages listed below.

```
clock-0.7.2
exceptions-0.10.0
hmatrix-0.19.0.0
cassava-0.5.1.0
Formatting-6.3.6
```

Please find the term life product with surrender decrement, morbidity decrement, and mortality decrement under main.hs.

```
stack ghci main.hs
```





## Contributing

Welcome to submit pull requests to me.


## License

This project is licensed under the MIT License - see [LICENSE.md](LICENSE.md) for details.

## Todo

This is a half-year undergraduate final year project. Due to the limitations in time and my experience in actuarial science, only a limited set of functions are implemented. More functions will be added as I gain more experience in actuarial science and Haskell.

* Extend the library to support valuation regulations like IFRS17, USGAAP, CROSS2, etc.

* Create a GUI to facilitate actuaries without experience with Haskell.

* Better support state models.
