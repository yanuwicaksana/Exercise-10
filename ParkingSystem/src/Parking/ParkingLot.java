package Parking;


import java.util.*;
/**
 * 
 * @author yanuarwicaksana
 *
 * Comments: This class represent the constructor for one parking lot. Each parking lot
 * 			 contained multiple different Parking Space. Parking Lot has a few features
 * 			 that can be used in our system.
 */
public class ParkingLot {
	private int available = 0;
	private int availableguest = 0;
	List parkinglist;
	List idlist;
	
	public ParkingLot(){
		this.parkinglist = new LinkedList();
		this.available = available;
		this.idlist = new LinkedList();
	}
	
	public List getparkinglist(){
		return parkinglist;
	}
	
	public void addParkingSpace(ParkingSpace space){
		if (!idlist.contains(space.getId())){
			parkinglist.add(space);
			idlist.add(space.getId());
			if(space.getAvailability()) available += 1;
			if(space.getAvailability() && space.getId()>20) availableguest += 1;
			
		} else{
			System.out.println("The id must be unique");
		}
		
	}
	
	public void checkavailable(){
		available = 0;
		for(int i = 0; i < parkinglist.size(); i++){
			ParkingSpace space = (ParkingSpace)parkinglist.get(i);
			if(space.getAvailability()){
				available += 1;
			}
			if(space.getAvailability() && space.getId()>20){
				availableguest += 1;
			}
		}
	}
	
	public int getavailablespace(){
		return available;
	}
	
	public int getavailableguestspace(){
		return availableguest;
	}
	
	public void checkin(ParkingSpace space){
		if (parkinglist.contains(space)){
			for(int i = 0; i < parkinglist.size(); i++){
				ParkingSpace park = (ParkingSpace) parkinglist.get(i);
				if(park.equals(space)){
					if(park.getAvailability()){
						park.setAvailability(false);
						checkavailable();
						System.out.println("Check In Succesful\n");
					} else{
						System.out.println("Cannot Check In at the specific spot\n");
					}
					break;
				}else continue;
			}
		} else{
			System.out.println("There are no specific Parking Space available\n");
		}
	}
	
	public void checkout(ParkingSpace space){
		if (parkinglist.contains(space)){
			for(int i = 0; i < parkinglist.size(); i++){
				ParkingSpace park = (ParkingSpace) parkinglist.get(i);
				if(park.equals(space)){
					if(!park.getAvailability()){
						park.setAvailability(true);
						checkavailable();
						System.out.println("Check out Succesful\n");
					} else{
						System.out.println("Cannot Check out at the specific spot\n");
					}
					break;
				}else continue;
			}
		} else{
			System.out.println("There are no specific Parking Space available\n");
		}
	}
}
