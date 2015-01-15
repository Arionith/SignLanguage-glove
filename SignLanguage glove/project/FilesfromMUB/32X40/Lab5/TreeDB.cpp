
#include<iostream>
#include "TreeDB.h"

/*TreeNode* root;
   int probesCount;*/
// the default constructor, creates an empty database.

TreeDB::TreeDB() {
    root = NULL;
    probesCount = 0;
}

// the destructor, deletes all the entries in the database.

TreeDB::~TreeDB() {
    if (root == NULL)return;
      delete root->getEntry();
}

// inserts the entry pointed to by newEntry into the database.
// If an entry with the same key as newEntry's exists
// in the database, it returns false. Otherwise, it returns true.

bool TreeDB::insert(DBentry* newEntry) {

    if (root == NULL) {
        TreeNode*temp = new TreeNode(newEntry);
        root = temp;
        return true;
    } else {
        TreeNode*temp = new TreeNode(newEntry);
        bool check = insert_bst(temp, root);
        if (check == false) {

            delete temp;
        }
        return check;
    }

    return false;
}
//The following privet function is a helper function for insert

bool TreeDB::insert_bst(TreeNode* p, TreeNode* r) {
    if (p->getEntry()->getName() == r->getEntry()->getName()) {

        return false;
    }
    if (p->getEntry()->getName() > r->getEntry()->getName()) {
        if (r->getRight() == NULL) {

            r->setRight(p);
            return true;
        } else {
            return insert_bst(p, r->getRight());

        }
    }

    if ((p->getEntry()->getName())<(r->getEntry()->getName())) {

        if (r->getLeft() == NULL) {
            r->setLeft(p);
            return true;

        } else {
            return insert_bst(p, r->getLeft());
        }
    }

    return false;
}

// searches the database for an entry with a key equal to name.
// If the entry is found, a pointer to it is returned.
// If the entry is not found, the NULL pointer is returned.
// Also sets probesCount

DBentry* TreeDB::find(string name) {
    DBentry*receive = NULL;
    probesCount = 0;
    if (root == NULL) {
        return NULL;
    } else {
        receive = find_helper(root, name);
        if (receive != NULL) {
            if (receive->getName() == name) {
                return receive;
            }
        }
    }

    return receive;
}

DBentry*TreeDB::find_helper(TreeNode*other, string name) {

    probesCount++;


    if (other != NULL) {
        if (other->getEntry()->getName() == name) {
            return other->getEntry();
        }
    }

    if (other->getLeft() != NULL) {

        return find_helper(other->getLeft(), name);
    }


    if (other->getRight() != NULL) {
        return find_helper(other->getRight(), name);

    }

    return NULL;
}

// deletes the entry with the specified name (key)  from the database.
// If the entry was indeed in the database, it returns true.
// Returns false otherwise.
// See section 6 of the lab handout for the *required* removal method.
// If you do not use that removal method (replace deleted node by
// maximum node in the left subtree when the deleted node has two children)
// you will not match exercise's output.
/*    if (other != NULL) {
        if (other->getEntry()->getName() == name) {

            if (other->getLeft() == NULL && other->getRight() == NULL) {
                delete other;
                other = NULL;
                return;
            } else if (other->getLeft() == NULL && other->getRight() != NULL) {
                TreeNode*temp = NULL;
                temp = other->getRight();
                other->setRight(NULL);
                delete other;
                other=NULL;
                other = temp;
                return;
            } else if (other->getLeft() != NULL && other->getRight() == NULL) {
                TreeNode*temp = NULL;
                temp = other->getLeft();
                delete other;
                other=NULL;
                other = temp;
                return;
            } else {
                TreeNode*tempLeft = other->getLeft();
                TreeNode*tempRight = other->getRight();
                TreeNode*bottomRight = other;
                TreeNode*temp = NULL;
                while (bottomRight->getRight() != NULL) {
                    temp = bottomRight;
                    bottomRight = temp->getRight();
                }
                delete other;
                other=NULL;
                other = tempLeft;
                bottomRight->setRight(tempRight);
                return;
            }

        }
    }*/
bool TreeDB::remove(string name) {
    TreeNode*receive;
    
    if (root == NULL) {
        return false;
    } else {
        DBentry*pointer;
        pointer=find(name);
        if(pointer==NULL){
            return false;
        }
        if(root->getEntry()->getName()==name && root->getLeft()==NULL&&root->getRight()==NULL){
        
                delete root;
                 root=NULL;
                 return true;
        }else if(root->getEntry()->getName()==name &&root->getLeft()==NULL&&root->getRight()!=NULL){
                TreeNode*temp = NULL;
                temp = root->getRight();
                root->setRight(NULL);
                delete root;
                root = temp;
                return true;
        }else if(root->getEntry()->getName()==name &&root->getLeft() != NULL && root->getRight() == NULL){
                TreeNode*temp = NULL;
                temp = root->getLeft();
                delete root;
                root = temp;
                return true;  
        } else {
        
                receive = removeHelper(root, name);
                TreeNode*temporary=receive;
                if(receive->getLeft()->getEntry()->getName() == name){
                
                    temporary=receive->getLeft();
                }else if(receive->getRight()->getEntry()->getName()==name){
                    temporary=receive->getRight();
                }
             if (temporary->getEntry()->getName() == name) {
                  
            if(temporary->getLeft()==NULL&&temporary->getRight()==NULL){
                if(receive->getLeft()->getEntry()->getName()==name){
                delete temporary;
                receive->setLeft(NULL);
                }else {
                
                    delete temporary;
                    receive->setRight(NULL);
                }
                return true;
        
            } else if (temporary->getLeft() == NULL && temporary->getRight() != NULL) {
                TreeNode*temp = NULL;
                temp = temporary->getRight();
                if(receive->getLeft()->getEntry()->getName()==name){
                    delete temporary;
                    receive->setLeft(temp);
                }else {
                    delete temporary;
                    receive->setRight(temp);
                    }
                return true;
            } else if (temporary->getLeft() != NULL && temporary->getRight() == NULL) {
                TreeNode*temp = NULL;
                temp = temporary->getLeft();
                if(receive->getLeft()->getEntry()->getName()==name){
                    delete temporary;
                    receive->setLeft(temp);
                }else {
                    delete temporary;
                    receive->setRight(temp);
                   }
                return true;
            } else {
                TreeNode*tempLeft = temporary->getLeft();
                TreeNode*tempRight = temporary->getRight();
                TreeNode*bottomRight = temporary;
                TreeNode*temp = NULL;
                while (bottomRight->getRight() != NULL) {
                    temp = bottomRight;
                    bottomRight = temp->getRight();
                }
                  if(receive->getLeft()->getEntry()->getName()==name){
                    delete temporary;
                    receive->setLeft(tempLeft);
                }else {
                    delete temporary;
                    receive->setRight(tempLeft);
                   }
                bottomRight->setRight(tempRight);
                return true;
            }

        }
         else return false;
        
        }

         
    }
    return true;
}
//The following helper function delete a node with a given key(Name)
TreeNode* TreeDB::removeHelper(TreeNode*other, string name) {
     
      
    if(other->getLeft()->getEntry()->getName()==name||other->getRight()->getEntry()->getName()==name)
     return other;
    
    if (other->getLeft() != NULL) {

        return removeHelper(other->getLeft(), name);
    }

    if (other->getRight() != NULL) {
        return removeHelper(other->getRight(), name);

    }
    return NULL;
}
// deletes all the entries in the database.

void TreeDB::clear() {

}

// prints the number of probes stored in probesCount

void TreeDB::printProbes() const {
    cout << probesCount << endl;
}

// computes and prints out the total number of active entries
// in the database (i.e. entries with active==true).

void TreeDB::countActive() {
    int numberOfActive = 0;

    if (root != NULL) {
        numberOfActive = countActiveHelper(root, numberOfActive);
    }


    cout << numberOfActive << endl;
    return;
}

int TreeDB::countActiveHelper(const TreeNode*other, int numberOfActive) {
    if (other->getEntry()->getActive()) {
        numberOfActive++;
    }


    if (other == NULL) {
        return numberOfActive;
    }

    if (other->getLeft() != NULL) {

        return countActiveHelper(other->getLeft(), numberOfActive);
    }


    if (other->getRight() != NULL) {
        return countActiveHelper(other->getRight(), numberOfActive);

    }
    return numberOfActive;
}



// Prints the entire tree, in ascending order of key/name

ostream& operator<<(ostream& out, TreeDB& rhs) {
    if(rhs.root==NULL) return out;
    rhs.printAll(rhs.root);
    return out;
}
// You *may* choose to implement the function below to help print the
// tree.  You do not have to implement this function if you do not wish to.

ostream& operator<<(ostream& out, TreeNode* rhs) {

    out << rhs->getEntry()->getName() << " : " << rhs->getEntry()->getIPaddress() << " : ";

    if (rhs->getEntry()->getActive() == true) {

        out << "active" << endl;
    } else {

        out << "inactive" << endl;
    }
    return out;
}
//The following privet function print the data at all nodes

void TreeDB::printAll(TreeNode*other) {

    if (other == NULL) {
        return;
    }

    if (other->getLeft() != NULL) {
        printAll(other->getLeft());

    }
       if(other->getEntry()!=NULL){
       cout << other->getEntry()->getName() << " : " << other->getEntry()->getIPaddress() << " : ";

        if (other->getEntry()->getActive() == true) {

            cout << "active" << endl;
        } else {

            cout << "inactive" << endl;
        }
       }
        
   

    if (other->getRight() != NULL) {

        printAll(other->getRight());
    }
    return;

}




