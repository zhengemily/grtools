// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// matrixloglikC
double matrixloglikC(NumericMatrix data, NumericMatrix means, List covmat, NumericMatrix b, NumericMatrix c);
RcppExport SEXP grtools_matrixloglikC(SEXP dataSEXP, SEXP meansSEXP, SEXP covmatSEXP, SEXP bSEXP, SEXP cSEXP) {
BEGIN_RCPP
    SEXP __sexp_result;
    {
        Rcpp::RNGScope __rngScope;
        Rcpp::traits::input_parameter< NumericMatrix >::type data(dataSEXP );
        Rcpp::traits::input_parameter< NumericMatrix >::type means(meansSEXP );
        Rcpp::traits::input_parameter< List >::type covmat(covmatSEXP );
        Rcpp::traits::input_parameter< NumericMatrix >::type b(bSEXP );
        Rcpp::traits::input_parameter< NumericMatrix >::type c(cSEXP );
        double __result = matrixloglikC(data, means, covmat, b, c);
        PROTECT(__sexp_result = Rcpp::wrap(__result));
    }
    UNPROTECT(1);
    return __sexp_result;
END_RCPP
}
