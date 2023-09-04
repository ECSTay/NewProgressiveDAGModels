data {
  int N;
  int N_A;
  int N_R;
  int A[N];
  int R[N];
}


parameters {
  vector[N_A] beta;
}

transformed parameters{
  vector[N] q;
  
  for(i in 1:N){
    q[i] = inv_logit(beta[A[i] + 1]);
  }
  
}

model {
  
  beta ~ normal( 0, 2);
  
  R ~ bernoulli(q);
  
}
