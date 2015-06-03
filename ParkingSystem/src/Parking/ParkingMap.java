package Parking;


import java.util.*;
/**
 * 
 * @author yanuarwicaksana
 *
 * Comments: This class represents a simple map object that will be displayed in the program.
 * The map is represented as a square with row and columns (assumes that there are 30 parking space with
 * each row has exactly 10 parking space). The map is stored inside a 2D array collection with row and column
 * serves as index for the array. This class also provided the direction method that return the nearest available
 * parking space.
 */

public class ParkingMap {
	private ParkingLot lot;
	private List map;
	int noofrow,noofcol;
	
	public ParkingMap(ParkingLot lot){
		this.lot = lot;
		this.noofrow = 3;
		this.noofcol = 10;
		this.map = new LinkedList();
		InitiateMap();
		InitiateGuestMap();
	}
	
	public void InitiateMap(){
		List space = lot.getparkinglist();
		int index = 0;
		for (int i = 0; i < noofrow; i++){
			List temp = new LinkedList();
			for (int j = 0; j < noofcol; j++){
				ParkingSpace park = (ParkingSpace) space.get(index);
				index += 1;
				temp.add(park);
			}
			map.add(temp);
		}		
	}
	
	public void InitiateGuestMap(){
		List space = lot.getparkinglist();
		int index = 0;
		for (int i = 2; i < noofrow; i++){
			List temp = new LinkedList();
			for (int j = 0; j < noofcol; j++){
				ParkingSpace park = (ParkingSpace) space.get(index);
				index += 1;
				temp.add(park);
			}
			map.add(temp);
		}		
	}
	
	public String getdirection(){
		String row = null,col = null;
		outerloop:
		for (int i = 0; i < map.size(); i++){
			List temp = (List) map.get(i);
			for (int j = 0; j < temp.size(); j++){
				ParkingSpace space = (ParkingSpace) temp.get(j);
				if (space.isAvailable){
					row = Integer.toString(i + 1);
					col = Integer.toString(j + 1);
					break outerloop;
				}
			}
		}
		return row + " " +  col;
	}
	
	public String getGuestdirection(){
		String row = null,col = null;
		outerloop:
		for (int i = 2; i < map.size(); i++){
			List temp = (List) map.get(i);
			for (int j = 0; j < temp.size(); j++){
				ParkingSpace space = (ParkingSpace) temp.get(j);
				if (space.isAvailable){
					row = Integer.toString(i + 1);
					col = Integer.toString(j + 1);
					break outerloop;
				}
			}
		}
		return row + " " +  col;
	}
	
}