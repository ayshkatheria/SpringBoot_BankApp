(I) Lets First Create .jar without using docker.
- 
# 1. Install Java open jdk17
sudo apt-get update
sudo apt-get install -y openjdk-17-jdk

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

Verify java version (it should be 17.0.x)
java -version
javac -version

# 2. Install Maven 3.8.3
   wget https://archive.apache.org/dist/maven/maven-3/3.8.3/binaries/apache-maven-3.8.3-bin.tar.gz
   tar -xvzf apache-maven-3.8.3-bin.tar.gz
   sudo mv apache-maven-3.8.3 /opt/maven

Set up environment variables
sudo tee /etc/profile.d/maven.sh > /dev/null <<EOF
export M2_HOME=/opt/maven
export PATH=\$M2_HOME/bin:\$PATH
EOF

Make the script executable
sudo chmod +x /etc/profile.d/maven.sh

Load the environment variables
source /etc/profile.d/maven.sh

mvn -v

# 3. Build .jar file
mvn clean install
output :- target/bankapp-0.0.1-SNAPSHOT.jar

# 4. Run jar file 
java -jar target/bankapp-0.0.1-SNAPSHOT.jar

# 5. Access the App in local
open the prot in inbound rules SG
http://localhost:8080


