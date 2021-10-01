
// top level module: 2 to 1 multiplexer

module mux2to1(x, y, s, m);
	
	input x, y, s;
	output m;

	
	// wire that connects pin2 of inverter 1 to pint 2 of AND gate 1
	wire inverter_pin2_to_AND1_pin2;
	
	// wire that connects pin3 of AND1 gate to pin1 of OR gate 1
	wire AND1_pin3_to_OR1_pin1;
	
	// wire that connects pint6 of AND2 gate to pin2 of OR gate 1
	wire AND1_pin6_to_OR1_pin2;
	
	// instance of the 7404 gate
	// connect pin1 to s and pin2 to wire
	v7404 NOT1(.pin1(s), .pin2(inverter_pin2_to_AND1_pin2));
	
	// instance of 7408 gate
	// connects x to pin1, links pin2 of NOT to pin2 of AND1 and creates wire b/w pin3 (output) of AND1 to input of OR1
	v7408 AND1(.pin1(x), .pin2(inverter_pin2_to_AND1_pin2), .pin3(AND1_pin3_to_OR1_pin1), .pin4(s), .pin5(y), .pin6(AND1_pin6_to_OR1_pin2));
	
	
	//v7408 AND2(.pin4(s), .pin5(y), .pin6(AND1_pin6_to_OR1_pin2));
	
	v7432 OR1(.pin1(AND1_pin3_to_OR1_pin1), .pin2(AND1_pin6_to_OR1_pin2), .pin3(m));	

endmodule
	

// 7404 chip (6 inverters (NOT gates))

module v7404 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);
	
	input pin1, pin3, pin5, pin9, pin11, pin13;
	output pin2, pin4, pin6, pin8, pin10, pin12;
	
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
	

endmodule

// 7408 chip (2 input AND gates)

module v7408 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);
	
	input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
	output pin3, pin6, pin8, pin11;
	
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;
	
endmodule

// 7432 chip (2 input OR gates)

module v7432 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);
	
	input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
	output pin3, pin6, pin8, pin11;
	
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
	
endmodule


