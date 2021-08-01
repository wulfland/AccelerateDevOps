# Review changes

This is the hands-on part in chapter 3 for reviewing changes - especially making suggestions.

1. Copy the following code to your clipboard by clicking the icon in the top right corner.

    ```javascript
        var lookup = { M:1000,CM:900,D:500,CD:400,C:100,XC:90,L:50,XL:40,X:10,IX:9,V:5,IV:4,I:1 };
        var roman = '';
        var i;
        for ( i in lookup ) {
        while ( num >= lookup[i] ) {
            roman += i;
            num -= lookup[i];
        }
        }
        return roman;
    ```

2. Navigate to [src/app.js](src/app.js) and edit the file by clicking the pencil :pencil: icon in the top right corner.

3. Delete line 2 and insert the code by presssing <kbd>Ctrl</kbd>+<kbd>V</kbd>.

4. Commit directly to the branch you created in [Create-PullRequest.md](Create-PullRequest.md)
