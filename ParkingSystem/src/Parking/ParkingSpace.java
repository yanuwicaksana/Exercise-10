package Parking;

/**
 * 
 * @author yanuarwicaksana
 *
 * Comments: This class represent the constructor for 1 specific parking spot.
 * 			 Each Parking Space are available for only one car and each specific Parking Space
 * 			 in 1 Parking Lot have an unique attribute that differentiate between one and others. 
 */
public class ParkingSpace {
	int id;
	boolean isAvailable = true;
	
	public ParkingSpace(int id){
		this.id = id;
		this.isAvailable = isAvailable;
	}
	
	public boolean getAvailability(){
		return isAvailable;
	}
	
	public int getId(){
		return id;
	}
	
	public void setAvailability(boolean ava){
		isAvailable = ava;
	}
	
	@Override
	public boolean equals(Object otherspace){
		boolean bool = false;
		if(otherspace != null && otherspace instanceof ParkingSpace ){
			bool = this.id == ((ParkingSpace) otherspace).id;
		}
		return bool;
	}
}
