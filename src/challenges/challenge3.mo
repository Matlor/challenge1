import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";


actor {
    private func swap(mutArr: [var Any], j:Nat, i: Nat): [var Any]{
        let store = mutArr[j];
        mutArr[j] := mutArr[i];
        mutArr[i] := store;
        return mutArr;
    };

    public func init_count(n:Nat,): async [Nat] {

        func gen(idx: Nat): Nat{
            return idx;
        };    

        let arr: [Nat] = Array.tabulate<Nat>(n, gen);
        return arr;
    };

    public func seven(array: [Nat]): async Text {
        let foundText = "Seven is found";
        let notFoundText = "Seven not found"; 
               
        for (i in array.vals()) {
            //Debug.print(debug_show(i));
            if(i == 7){
               return foundText;
           }; 
            
        };
        return notFoundText;
    };

    public func nat_opt_to_nat(n: ?Nat, m:Nat): async Nat {
        switch(n){
            case(null) {
                return m;
            };
            case(?v){
                return v;
            };
        };
               
    };


    public func day_of_the_week(n: Nat): async ?Text {
        switch(n){
            case(1){return ?"monday";};
            case(2){return ?"tuesday";};
            case(3){return ?"wednesday";};
            case(4){return ?"thursday";};
            case(5){return ?"friday";};
            case(6){return ?"saturday";};
            case(7){return ?"sunday";};
            case(v){return null;};
        };
    };

    public func populate_array(array: [?Nat]): async [Nat] {
        
        func transform(opt: ?Nat): Nat {
            switch (opt){
                case(null){return 0;};
                case(?v){return v;};
            };
        };

       let newArr= Array.map(array, transform);

        return newArr;
    };

    public func sum_of_array(array: [Nat]): async Nat {
        var sum = 0;
        func addUp(val: Nat): Nat {
           sum+= val;
           Debug.print(debug_show(val));

           return val;
        };
        let newArr = Array.map(array, addUp);

        Debug.print(debug_show(sum));
        return sum;
    };


    public func squared_array(array: [Nat]): async [Nat] {
       
        func square(val: Nat): Nat {
           
           return val**2;
        };
        let newArr = Array.map(array, square);

        return newArr;
    };
    

    public func increase_by_index(array: [Nat]): async [Nat] {
        var index = 0; 
        func addIndex(val: Nat): Nat {
           index+=1; 
           return val + index-1;
        };
        let newArr = Array.map(array, addIndex);
        return newArr;
    };

    private func contains<A>(xs: [A], a:A, f:(A,A)->Bool): Bool {
        for(x in xs.vals()){
            if(f(a, x)){
                return true;
            };
        };
        return false;
    }; 

    public func test_contain(myarray : [Nat], a: Nat) : async Bool {
        let compareFunc = func (a : Nat, b : Nat) : Bool {
            if ( a == b ) {
            return true;
            };
            return false;
        };

        return (contains<Nat>(myarray, a, compareFunc));
    };
    
};




