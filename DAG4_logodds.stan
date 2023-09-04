data{
  
  int N;
  int N_A;
  int N_S;
  int N_R;
  int N_M;
  int N_D;
  array[N] int A;
  array[N] int S;
  array[N] int R;
  array[N] int M;
  array[N] int D;
  }
  
parameters{
  array[N_A, N_S] real alpha;
  array[N_A] real beta;
  array[N_A, N_S] real gamma;
  array[N_M] real delta;
}

transformed parameters{
  vector[N] p;
  vector[N] q;
  vector[N] g;
  vector[N] h;
  
  vector[N_A*N_S] alpha_vec;
  vector[N_A] beta_vec;
  vector[N_A*N_S] gamma_vec;
  
  for(i in 1:N){
    p[i] = inv_logit(alpha[A[i] + 1][S[i] + 1]);
    q[i] = inv_logit(beta[A[i] + 1]);
    g[i] = inv_logit(gamma[A[i] + 1][S[i] + 1]);
    h[i] = R[i]*inv_logit(delta[M[i] + 1]);
  }
  
  alpha_vec = to_vector(to_array_1d(alpha));
  beta_vec = to_vector(to_array_1d(beta));
  gamma_vec = to_vector(to_array_1d(gamma));
}
model{
  
  //priors
  alpha_vec ~ normal(0, 2);
  
  //likelihood
  R ~ bernoulli( p );
  
  //priors
  beta_vec ~ normal( 0, 2);
  
  //likelihood
  S ~ bernoulli(q);
  
  //priors
  gamma_vec ~ normal(-4.59,2);
  
  //likelihood
  M ~ bernoulli( g );
  
  //priors
 
  delta[1] ~ normal(-5, 1);
  delta[2] ~ normal(5, 1);
  
  //likelihood
  D ~ bernoulli(h);
  
}
