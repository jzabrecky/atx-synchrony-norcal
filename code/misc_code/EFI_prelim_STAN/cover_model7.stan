data {
  int<lower=0> N_days; //number of days
  vector[N_days] cover; //% cover of cyano
  vector[N_days] prior_cover; // autoregressive component; prior 
  vector[N_days] GPP; //gross primary productivity
}


parameters {
  real b0;
  real b1;
  real b2;
  real<lower=0> sigma;
}

model {
  for(i in 1:N_days) {
    cover[i] ~ normal((b0+b1*prior_cover[i]+b2*GPP[i]), sigma);
  }
  
  //Priors ex. from where this came
  b0~normal(0,10);
  b1~normal(0,10);
  b2~normal(0,10);
  sigma~normal(0,10)T[0,];
}