// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// Delta3DWeightsC
arma::cube Delta3DWeightsC(arma::cube vx, Rcpp::NumericVector Datasample);
RcppExport SEXP _DatabionicSwarm_Delta3DWeightsC(SEXP vxSEXP, SEXP DatasampleSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< arma::cube >::type vx(vxSEXP);
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type Datasample(DatasampleSEXP);
    rcpp_result_gen = Rcpp::wrap(Delta3DWeightsC(vx, Datasample));
    return rcpp_result_gen;
END_RCPP
}
// DijkstraSSSP
NumericVector DijkstraSSSP(NumericMatrix Adj, NumericMatrix Costs, int source);
RcppExport SEXP _DatabionicSwarm_DijkstraSSSP(SEXP AdjSEXP, SEXP CostsSEXP, SEXP sourceSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericMatrix >::type Adj(AdjSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type Costs(CostsSEXP);
    Rcpp::traits::input_parameter< int >::type source(sourceSEXP);
    rcpp_result_gen = Rcpp::wrap(DijkstraSSSP(Adj, Costs, source));
    return rcpp_result_gen;
END_RCPP
}
// PswarmRadiusParallel
List PswarmRadiusParallel(NumericVector DataBotsPos, NumericVector DataDists, NumericVector AllallowedDBPosR0, NumericVector IndPossibleDBPosRe, NumericVector IndPossibleDBPosIm, int Lines, int Columns, int Radius, int NumAllDB, int NumChoDB, int NumFreeShape1, int NumJumps, int Origin1, int Origin2, double Happiness, int MinIterations, int HappinessInclination, double Eps, bool debug);
RcppExport SEXP _DatabionicSwarm_PswarmRadiusParallel(SEXP DataBotsPosSEXP, SEXP DataDistsSEXP, SEXP AllallowedDBPosR0SEXP, SEXP IndPossibleDBPosReSEXP, SEXP IndPossibleDBPosImSEXP, SEXP LinesSEXP, SEXP ColumnsSEXP, SEXP RadiusSEXP, SEXP NumAllDBSEXP, SEXP NumChoDBSEXP, SEXP NumFreeShape1SEXP, SEXP NumJumpsSEXP, SEXP Origin1SEXP, SEXP Origin2SEXP, SEXP HappinessSEXP, SEXP MinIterationsSEXP, SEXP HappinessInclinationSEXP, SEXP EpsSEXP, SEXP debugSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type DataBotsPos(DataBotsPosSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type DataDists(DataDistsSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type AllallowedDBPosR0(AllallowedDBPosR0SEXP);
    Rcpp::traits::input_parameter< NumericVector >::type IndPossibleDBPosRe(IndPossibleDBPosReSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type IndPossibleDBPosIm(IndPossibleDBPosImSEXP);
    Rcpp::traits::input_parameter< int >::type Lines(LinesSEXP);
    Rcpp::traits::input_parameter< int >::type Columns(ColumnsSEXP);
    Rcpp::traits::input_parameter< int >::type Radius(RadiusSEXP);
    Rcpp::traits::input_parameter< int >::type NumAllDB(NumAllDBSEXP);
    Rcpp::traits::input_parameter< int >::type NumChoDB(NumChoDBSEXP);
    Rcpp::traits::input_parameter< int >::type NumFreeShape1(NumFreeShape1SEXP);
    Rcpp::traits::input_parameter< int >::type NumJumps(NumJumpsSEXP);
    Rcpp::traits::input_parameter< int >::type Origin1(Origin1SEXP);
    Rcpp::traits::input_parameter< int >::type Origin2(Origin2SEXP);
    Rcpp::traits::input_parameter< double >::type Happiness(HappinessSEXP);
    Rcpp::traits::input_parameter< int >::type MinIterations(MinIterationsSEXP);
    Rcpp::traits::input_parameter< int >::type HappinessInclination(HappinessInclinationSEXP);
    Rcpp::traits::input_parameter< double >::type Eps(EpsSEXP);
    Rcpp::traits::input_parameter< bool >::type debug(debugSEXP);
    rcpp_result_gen = Rcpp::wrap(PswarmRadiusParallel(DataBotsPos, DataDists, AllallowedDBPosR0, IndPossibleDBPosRe, IndPossibleDBPosIm, Lines, Columns, Radius, NumAllDB, NumChoDB, NumFreeShape1, NumJumps, Origin1, Origin2, Happiness, MinIterations, HappinessInclination, Eps, debug));
    return rcpp_result_gen;
END_RCPP
}
// PswarmRadiusSequential
List PswarmRadiusSequential(ComplexVector AllDataBotsPosOld, double Radius, NumericMatrix DataDists, ComplexVector IndPossibleDBPosR, NumericMatrix RadiusPositionsschablone, NumericVector pp, NumericVector Nullpunkt, double Lines, double Columns, double nBots, int limit, int steigungsverlaufind, double Happiness, bool debug);
RcppExport SEXP _DatabionicSwarm_PswarmRadiusSequential(SEXP AllDataBotsPosOldSEXP, SEXP RadiusSEXP, SEXP DataDistsSEXP, SEXP IndPossibleDBPosRSEXP, SEXP RadiusPositionsschabloneSEXP, SEXP ppSEXP, SEXP NullpunktSEXP, SEXP LinesSEXP, SEXP ColumnsSEXP, SEXP nBotsSEXP, SEXP limitSEXP, SEXP steigungsverlaufindSEXP, SEXP HappinessSEXP, SEXP debugSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< ComplexVector >::type AllDataBotsPosOld(AllDataBotsPosOldSEXP);
    Rcpp::traits::input_parameter< double >::type Radius(RadiusSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type DataDists(DataDistsSEXP);
    Rcpp::traits::input_parameter< ComplexVector >::type IndPossibleDBPosR(IndPossibleDBPosRSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type RadiusPositionsschablone(RadiusPositionsschabloneSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type pp(ppSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type Nullpunkt(NullpunktSEXP);
    Rcpp::traits::input_parameter< double >::type Lines(LinesSEXP);
    Rcpp::traits::input_parameter< double >::type Columns(ColumnsSEXP);
    Rcpp::traits::input_parameter< double >::type nBots(nBotsSEXP);
    Rcpp::traits::input_parameter< int >::type limit(limitSEXP);
    Rcpp::traits::input_parameter< int >::type steigungsverlaufind(steigungsverlaufindSEXP);
    Rcpp::traits::input_parameter< double >::type Happiness(HappinessSEXP);
    Rcpp::traits::input_parameter< bool >::type debug(debugSEXP);
    rcpp_result_gen = Rcpp::wrap(PswarmRadiusSequential(AllDataBotsPosOld, Radius, DataDists, IndPossibleDBPosR, RadiusPositionsschablone, pp, Nullpunkt, Lines, Columns, nBots, limit, steigungsverlaufind, Happiness, debug));
    return rcpp_result_gen;
END_RCPP
}
// findPossiblePositionsCsingle
ComplexVector findPossiblePositionsCsingle(NumericMatrix RadiusPositionsschablone, double jumplength, double alpha, double Lines);
RcppExport SEXP _DatabionicSwarm_findPossiblePositionsCsingle(SEXP RadiusPositionsschabloneSEXP, SEXP jumplengthSEXP, SEXP alphaSEXP, SEXP LinesSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericMatrix >::type RadiusPositionsschablone(RadiusPositionsschabloneSEXP);
    Rcpp::traits::input_parameter< double >::type jumplength(jumplengthSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< double >::type Lines(LinesSEXP);
    rcpp_result_gen = Rcpp::wrap(findPossiblePositionsCsingle(RadiusPositionsschablone, jumplength, alpha, Lines));
    return rcpp_result_gen;
END_RCPP
}
// rDistanceToroidCsingle
NumericMatrix rDistanceToroidCsingle(NumericVector AllDataBotsPosX, NumericVector AllDataBotsPosY, NumericMatrix AllallowedDBPosR0, double Lines, double Columns, NumericVector Nullpunkt);
RcppExport SEXP _DatabionicSwarm_rDistanceToroidCsingle(SEXP AllDataBotsPosXSEXP, SEXP AllDataBotsPosYSEXP, SEXP AllallowedDBPosR0SEXP, SEXP LinesSEXP, SEXP ColumnsSEXP, SEXP NullpunktSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type AllDataBotsPosX(AllDataBotsPosXSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type AllDataBotsPosY(AllDataBotsPosYSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type AllallowedDBPosR0(AllallowedDBPosR0SEXP);
    Rcpp::traits::input_parameter< double >::type Lines(LinesSEXP);
    Rcpp::traits::input_parameter< double >::type Columns(ColumnsSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type Nullpunkt(NullpunktSEXP);
    rcpp_result_gen = Rcpp::wrap(rDistanceToroidCsingle(AllDataBotsPosX, AllDataBotsPosY, AllallowedDBPosR0, Lines, Columns, Nullpunkt));
    return rcpp_result_gen;
END_RCPP
}
// rcppPar_DistanceToroid
NumericMatrix rcppPar_DistanceToroid(NumericVector AllDataBotsPosX, NumericVector AllDataBotsPosY, NumericMatrix AllallowedDBPosR0, double Lines, double Columns, NumericVector Nullpunkt);
RcppExport SEXP _DatabionicSwarm_rcppPar_DistanceToroid(SEXP AllDataBotsPosXSEXP, SEXP AllDataBotsPosYSEXP, SEXP AllallowedDBPosR0SEXP, SEXP LinesSEXP, SEXP ColumnsSEXP, SEXP NullpunktSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type AllDataBotsPosX(AllDataBotsPosXSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type AllDataBotsPosY(AllDataBotsPosYSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type AllallowedDBPosR0(AllallowedDBPosR0SEXP);
    Rcpp::traits::input_parameter< double >::type Lines(LinesSEXP);
    Rcpp::traits::input_parameter< double >::type Columns(ColumnsSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type Nullpunkt(NullpunktSEXP);
    rcpp_result_gen = Rcpp::wrap(rcppPar_DistanceToroid(AllDataBotsPosX, AllDataBotsPosY, AllallowedDBPosR0, Lines, Columns, Nullpunkt));
    return rcpp_result_gen;
END_RCPP
}
// sampleC
arma::vec sampleC(NumericVector x, double len);
RcppExport SEXP _DatabionicSwarm_sampleC(SEXP xSEXP, SEXP lenSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< double >::type len(lenSEXP);
    rcpp_result_gen = Rcpp::wrap(sampleC(x, len));
    return rcpp_result_gen;
END_RCPP
}
// trainstepC
arma::cube trainstepC(Rcpp::NumericVector vx, Rcpp::NumericVector vy, Rcpp::NumericMatrix DataSampled, Rcpp::NumericMatrix BMUsampled, double Lines, double Columns, double Radius, bool toroid, int NoCases);
RcppExport SEXP _DatabionicSwarm_trainstepC(SEXP vxSEXP, SEXP vySEXP, SEXP DataSampledSEXP, SEXP BMUsampledSEXP, SEXP LinesSEXP, SEXP ColumnsSEXP, SEXP RadiusSEXP, SEXP toroidSEXP, SEXP NoCasesSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type vx(vxSEXP);
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type vy(vySEXP);
    Rcpp::traits::input_parameter< Rcpp::NumericMatrix >::type DataSampled(DataSampledSEXP);
    Rcpp::traits::input_parameter< Rcpp::NumericMatrix >::type BMUsampled(BMUsampledSEXP);
    Rcpp::traits::input_parameter< double >::type Lines(LinesSEXP);
    Rcpp::traits::input_parameter< double >::type Columns(ColumnsSEXP);
    Rcpp::traits::input_parameter< double >::type Radius(RadiusSEXP);
    Rcpp::traits::input_parameter< bool >::type toroid(toroidSEXP);
    Rcpp::traits::input_parameter< int >::type NoCases(NoCasesSEXP);
    rcpp_result_gen = Rcpp::wrap(trainstepC(vx, vy, DataSampled, BMUsampled, Lines, Columns, Radius, toroid, NoCases));
    return rcpp_result_gen;
END_RCPP
}
// trainstepC2
NumericVector trainstepC2(NumericVector esomwts, NumericVector aux, NumericMatrix DataSampled, NumericMatrix BMUsampled, double Lines, double Columns, double Weights, double Radius, bool toroid, int NoCases);
RcppExport SEXP _DatabionicSwarm_trainstepC2(SEXP esomwtsSEXP, SEXP auxSEXP, SEXP DataSampledSEXP, SEXP BMUsampledSEXP, SEXP LinesSEXP, SEXP ColumnsSEXP, SEXP WeightsSEXP, SEXP RadiusSEXP, SEXP toroidSEXP, SEXP NoCasesSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type esomwts(esomwtsSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type aux(auxSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type DataSampled(DataSampledSEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type BMUsampled(BMUsampledSEXP);
    Rcpp::traits::input_parameter< double >::type Lines(LinesSEXP);
    Rcpp::traits::input_parameter< double >::type Columns(ColumnsSEXP);
    Rcpp::traits::input_parameter< double >::type Weights(WeightsSEXP);
    Rcpp::traits::input_parameter< double >::type Radius(RadiusSEXP);
    Rcpp::traits::input_parameter< bool >::type toroid(toroidSEXP);
    Rcpp::traits::input_parameter< int >::type NoCases(NoCasesSEXP);
    rcpp_result_gen = Rcpp::wrap(trainstepC2(esomwts, aux, DataSampled, BMUsampled, Lines, Columns, Weights, Radius, toroid, NoCases));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_DatabionicSwarm_Delta3DWeightsC", (DL_FUNC) &_DatabionicSwarm_Delta3DWeightsC, 2},
    {"_DatabionicSwarm_DijkstraSSSP", (DL_FUNC) &_DatabionicSwarm_DijkstraSSSP, 3},
    {"_DatabionicSwarm_PswarmRadiusParallel", (DL_FUNC) &_DatabionicSwarm_PswarmRadiusParallel, 19},
    {"_DatabionicSwarm_PswarmRadiusSequential", (DL_FUNC) &_DatabionicSwarm_PswarmRadiusSequential, 14},
    {"_DatabionicSwarm_findPossiblePositionsCsingle", (DL_FUNC) &_DatabionicSwarm_findPossiblePositionsCsingle, 4},
    {"_DatabionicSwarm_rDistanceToroidCsingle", (DL_FUNC) &_DatabionicSwarm_rDistanceToroidCsingle, 6},
    {"_DatabionicSwarm_rcppPar_DistanceToroid", (DL_FUNC) &_DatabionicSwarm_rcppPar_DistanceToroid, 6},
    {"_DatabionicSwarm_sampleC", (DL_FUNC) &_DatabionicSwarm_sampleC, 2},
    {"_DatabionicSwarm_trainstepC", (DL_FUNC) &_DatabionicSwarm_trainstepC, 9},
    {"_DatabionicSwarm_trainstepC2", (DL_FUNC) &_DatabionicSwarm_trainstepC2, 10},
    {NULL, NULL, 0}
};

RcppExport void R_init_DatabionicSwarm(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
