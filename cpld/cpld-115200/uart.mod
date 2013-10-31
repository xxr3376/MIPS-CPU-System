MODEL
MODEL_VERSION "v1998.8";
DESIGN "uart";

/* port names and type */
INPUT S:PIN4 = rst;
INPUT S:PIN1 = clk;
INPUT S:PIN40 = wrn;
INPUT S:PIN58 = rxd;
INPUT S:PIN43 = rdn;
OUTPUT S:PIN42 = tbre;
OUTPUT S:PIN54 = sdo;
OUTPUT S:PIN41 = tsre;
OUTPUT S:PIN50 = data_ready;
OUTPUT S:PIN49 = framing_error;
OUTPUT S:PIN46 = parity_error;
OUTPUT S:PIN6 = data<0>;
OUTPUT S:PIN7 = data<1>;
OUTPUT S:PIN8 = data<2>;
OUTPUT S:PIN9 = data<3>;
OUTPUT S:PIN10 = data<4>;
OUTPUT S:PIN11 = data<5>;
OUTPUT S:PIN12 = data<6>;
OUTPUT S:PIN13 = data<7>;

/* timing arc definitions */
clk_tbre_delay: DELAY clk tbre;
clk_sdo_delay: DELAY clk sdo;
clk_tsre_delay: DELAY clk tsre;
clk_data_ready_delay: DELAY clk data_ready;
clk_framing_error_delay: DELAY clk framing_error;
clk_parity_error_delay: DELAY clk parity_error;

/* timing check arc definitions */
rst_clk_setup: SETUP(POSEDGE) rst clk;
rst_clk_hold: HOLD(POSEDGE) rst clk;

ENDMODEL
