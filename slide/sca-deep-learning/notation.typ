// Shared by the presentation and the original schematic diagrams.
// K*, P_i, C_i: full AES key and blocks; k*, k, p_i: target byte.
// x_i(t): measured leakage; z_i*: true intermediate; z_i(k): hypothesis under k.
// Introduce in this order: trace x_i(t), true z_i*, HD/HW, candidate z_i(k), score D.
// T_N (calligraphic): attack transcript; D(k; T_N): candidate score.
// h: manual leakage model; g_theta: leakage regression; q_theta: posterior.
// N_p: profiling traces; N: attack traces; T: samples per trace.
// c: class index; a_c: pre-Softmax score; y_j(c): one-hot target.
// ell_j: single-sample cross-entropy; theta: network parameters; eta: step size.
#let HW = math.op("HW")
#let HD = math.op("HD")
#let Sbox = math.op("Sbox")
#let Corr = math.op("Corr")
#let EE = math.op("E")
#let Pr = math.op("Pr")
#let softmax = math.op("softmax")
#let rank = math.op("rank")
#let GE = math.op("GE")
#let SR = math.op("SR")
#let SH = math.op("SH")

// Reusable equations prevent notation drift across introductory and paper slides.
#let key-decision = $hat(k) = arg max_k D(k; cal(T)_N)$
#let byte-hypothesis = $z_(i)(k) = Sbox(p_i xor k)$
#let cpa-score = $D_("CPA")(k; cal(T)_N) = max_t abs(Corr_(i)(h(z_(i)(k)), x_(i)(t)))$
#let posterior-score = $D_("NN")(k; cal(T)_N) = sum_(i=1)^N log q_(theta)(z_(i)(k) | x_i)$
