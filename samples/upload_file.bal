import ballerina/log;
import ballerina/os;
import ballerinax/googleapis_drive as drive;

configurable string clientId = os:getEnv("CLIENT_ID");
configurable string clientSecret = os:getEnv("CLIENT_SECRET");
configurable string refreshToken = os:getEnv("REFRESH_TOKEN");
configurable string refreshUrl = os:getEnv("REFRESH_URL");

string locaFilePath = "<PATH_TO_FILE_TO_BE_UPLOADED>";

###################################################
# Upload file 
# #################################################

public function main() {

    drive:Configuration config = {
        clientConfig: {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshUrl: refreshUrl,
            refreshToken: refreshToken
        }
    };
    drive:Client driveClient = new (config);
    
    drive:File|error res = driveClient->uploadFile(locaFilePath);
    // drive:File|error res = driveClient->uploadFile(locaFilePath, fileName);
    // drive:File|error res = driveClient->uploadFile(locaFilePath, fileName, parentFolderId);

    //Print file ID
    if(res is drive:File){
        string id = res?.id.toString();
        log:print(id);
    } else {
        log:printError(res.message());
    }
}
