data {
  int<lower=0> N_days; //number of days
  vector[N_days] cover; //% cover of cyano
  vector[N_days] atx; //anatoxin concentraitons
  vector[N_days] GPP; //past four days of GPP averaged
}


parameters {
  real b0;
  real b1;
  real b2;
  real b3;
  real<lower=0> sigma;
}

model {
  for(i in 2:N_days) {
    atx[i] ~ normal((b0+b1*atx[i-1]+b2*cover[i]+b3*GPP[i]), sigma);
  }
  
  //Priors ex. from where this came
  b0~normal(0,10);
  b1~normal(0,10);
  b2~normal(0,10);
  b3~normal(0,10);
  sigma~normal(0,10)T[0,];
}
