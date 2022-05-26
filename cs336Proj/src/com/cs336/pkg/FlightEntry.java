package com.cs336.pkg;

import java.math.BigDecimal;
import java.time.*;

public class FlightEntry {
	public int Flight_number;
	public String Flight_type;
	public String Airline;
	public String Class;
	public LocalDateTime Flight_date_time;
	public LocalDateTime Landing_date_time;
	public String Departing_airport;
	public String Landing_airport;
	public int Seat_number;//-1 means waiting list flight entry
	public BigDecimal Change_fee; 
	
	public FlightEntry(int Flight_number, String Flight_type, String Airline, String Class, String Flight_date, String Flight_time, String Landing_date,
			String Landing_time, String Departing_airport, String Landing_airport, int Seat_number, BigDecimal Change_fee) 
	{
		this.Flight_number = Flight_number;
		this.Flight_type = Flight_type;
		this.Airline = Airline;
		this.Class = Class;
		this.Flight_date_time = LocalDateTime.parse(Flight_date + "T" +Flight_time);
		this.Landing_date_time = LocalDateTime.parse(Landing_date + "T" +Landing_time);
		this.Departing_airport = Departing_airport;
		this.Landing_airport = Landing_airport;
		this.Seat_number = Seat_number;
		this.Change_fee = Change_fee;
	}
	public int compareTo(FlightEntry fe) {//maybe not necessary
		if(this.Flight_date_time.isBefore(fe.Flight_date_time)) {
			return -1;
		}
		else if(this.Flight_date_time.isAfter(fe.Flight_date_time)) {
			return 1;
		}
		return 0;
	}
	public String getFlight_date_time() {
		String[] temp = this.Flight_date_time.toString().split("T");
		return temp[0] + " " + temp[1];
	}
	public String getLanding_date_time() {
		String[] temp = this.Landing_date_time.toString().split("T");
		return temp[0] + " " + temp[1];
	}
}
