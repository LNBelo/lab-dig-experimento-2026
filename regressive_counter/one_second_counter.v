module one_second_counter (
	input clock,
	input reset,
	input start,
	output finished
);

integer one_second = 50_000_000;
integer clock_counter = 0;

reg finished_detect = 1'b0;

always @(posedge clock) begin
	if (reset) begin
		clock_counter <= 0;
		finished_detect <= 1'b0;
	end else begin
		if (start) begin
			clock_counter <= clock_counter + 1;
			if (clock_counter == one_second - 1) begin //compensation
				clock_counter <= 0;
				finished_detect <= 1'b1;
			end else begin
				finished_detect <= 1'b0;
			end
		end
	end
end

assign finished = finished_detect;

endmodule