-- Insert Track
CREATE OR ALTER PROCEDURE InsertTrack
    @ManagerID INT,
    @TrackName VARCHAR(255),
    @DeptID INT
AS
BEGIN    
    -- Check if the Manager ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Manger WHERE Manger_ID = @ManagerID)
    BEGIN
        PRINT 'Error: Manager ID does not exist.';
        RETURN;
    END

    -- Check if the Department ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Department WHERE Dept_ID = @DeptID)
    BEGIN
        PRINT 'Error: Department ID does not exist.';
        RETURN;
    END

    -- Insert new Track record
    INSERT INTO Manager.Track (Track_Name, Dept_ID, Manger_ID)
    VALUES (UPPER(@TrackName), @DeptID, @ManagerID);

    PRINT 'Track inserted successfully.';
END;

EXEC InsertTrack @ManagerID = 1, @TrackName = 'test', @DeptID = 2;

------------------------------------------------------------
GO
-- Update Track
CREATE OR ALTER PROCEDURE UpdateTrack
    @ManagerID INT,
    @OldTrackName VARCHAR(255),
    @NewTrackName VARCHAR(255),
    @NewDeptID INT
AS
BEGIN    
    -- Check if the Manager ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Manger WHERE Manger_ID = @ManagerID)
    BEGIN
        PRINT 'Error: Manager ID does not exist.';
        RETURN;
    END

    -- Check if the new Department ID exists
    IF NOT EXISTS (SELECT 1 FROM Manager.Department WHERE Dept_ID = @NewDeptID)
    BEGIN
        PRINT 'Error: Department ID does not exist.';
        RETURN;
    END

    -- Update Track Name and Department ID
    UPDATE Manager.Track
    SET Track_Name = UPPER(@NewTrackName),
        Dept_ID = @NewDeptID
    WHERE LOWER(Track_Name) = LOWER(@OldTrackName);

    PRINT 'Track name and Department ID updated successfully.';
END;

EXEC UpdateTrack 
    @ManagerID = 1, 
    @OldTrackName = 'DevOps', 
    @NewTrackName = 'Programming', 
    @NewDeptID = 2;
