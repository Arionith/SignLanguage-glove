/*
 * File:   Main.cpp
 * Author: Mubarek
 *
 * Created on November 11, 2014, 8:46 PM
 */

#include <cstdlib>

#include <iostream>
#include <string>
#include <sstream>
#include "DBentry.h"
#include "TreeDB.h"
#include "TreeNode.h"

using namespace std;
/*
 
 insert www.kk.com 8448 active
 insert www.abc.com 8393 active
 insert www.ola.com 382929 active
 
 */

int main(int argc, char **argv) {

    TreeDB input;

    string name, command, status, line;
    unsigned int IPaddress;



    bool check;
    cout << ">";

    getline(cin, line);

    while (!cin.eof()) {
        stringstream lineStream(line);
        lineStream >> command;

        if (command == "insert") {
            lineStream >> name;
            lineStream >> IPaddress;
            lineStream >> status;
            DBentry*ptr;
            if (status == "active")
                check = true;
            else
                check = false;
            //first check for existence of the entry??
            ptr = input.find(name);

            if (ptr == NULL) {

               DBentry*ptr = new DBentry(name, IPaddress, check);

                input.insert(ptr);
                cout<<"Success"<<endl;
            }
            else {
                cout<<"Error: entry already exists"<<endl;

            }        

        } else if (command == "find") {
            lineStream >> name;
            DBentry*ptr;
            ptr = input.find(name);

            if (ptr == NULL) {

                cout << "Error: entry does not exist" << endl;
            }
            else {
                cout << ptr->getName() << " : " << ptr->getIPaddress() << " : ";

                if (ptr->getActive() == true) {

                    cout << "active" << endl;
                } else {

                    cout << "inactive" << endl;
                }

            }

        } else if (command == "updatestatus") {
            lineStream >> name;
            lineStream >> status;
            bool set;
            if(status == "active"){
                set=true;
            }else {
                set=false;
            }
             DBentry*ptr;
            ptr = input.find(name);
            
            if (ptr == NULL) {

                cout << "Error: entry does not exist" << endl;
            }
            else {
                
                 ptr->setActive(set);
                 cout<<"Success"<<endl;
            }

        } else if (command == "printall") {//No argument

            cout << input;

        } else if (command == "printprobes") {
           lineStream >> name;
            
             DBentry*ptr;
            ptr = input.find(name);

            if (ptr == NULL) {

                cout << "Error: entry does not exist" << endl;
            }
            else {
                
             input.printProbes();
            }
           

        } else if (command == "remove") {
            lineStream >> name;
            bool check;
            check=   input.remove(name);
            if(check==false){
            
                cout<<"Error: entry does not exist"<<endl;
            }else{
            
                cout<<"Success"<<endl;
            }
             

        } else if(command == "removeall"){
        
            
        }else if (command == "countactive") {
            input.countActive();
        } else {
            cout << "Invalid command" << endl;
        }
        cout << ">";
        getline(cin, line);

    }


    return 0;
}


