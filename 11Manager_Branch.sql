-- Insert Branch
CREATE OR ALTER PROCEDURE InsertBranch
    @ManagerID INT,
    @BranchName VARCHAR(255)
AS
BEGIN    
    -- Check if the Manager ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Manger WHERE Manger_ID = @ManagerID)
    BEGIN
        PRINT 'Error: Manager ID does not exist.';
        RETURN;
    END

    -- Insert new Branch record
    INSERT INTO Manager.Branch (Branch_Name, Manger_ID)
    VALUES (@BranchName, @ManagerID);

    PRINT 'Branch inserted successfully.';
END;

GO

-- Execute example
EXEC InsertBranch @ManagerID = 5, @BranchName = 'Test2';

------------------------------------------------------------

GO

-- Edit Branch
CREATE OR ALTER PROCEDURE EditBranch
    @OldName VARCHAR(255),
    @NewBranchName VARCHAR(255),
    @ManagerID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Manager.Manger WHERE Manger_ID = @ManagerID)
    BEGIN
        PRINT 'Error: Manager ID does not exist.';
        RETURN;
    END

    -- Check if the Branch ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Branch WHERE LOWER(Branch_Name) = LOWER(@OldName))
    BEGIN
        PRINT 'Error: Branch ID does not exist.';
        RETURN;
    END

    -- Update Branch Name
    UPDATE Manager.Branch
    SET Branch_Name = UPPER(@NewBranchName),
        Manger_ID = @ManagerID
    WHERE Branch_Name = @OldName;

    PRINT 'Branch name updated successfully.';
END;

-- Execute example
EXEC EditBranch @OldName = 'Fayoum', @NewBranchName = 'Test3', @ManagerID = 8;
