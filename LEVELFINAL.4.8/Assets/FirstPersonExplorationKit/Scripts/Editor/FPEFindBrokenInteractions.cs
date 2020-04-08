using UnityEngine;
using UnityEditor;
using Whilefun.FPEKit;

//
// FindBrokenInteractions
// This script contains logic to valid your scene for save/load name uniqueness for certain object types.
//
// Copyright 2018 While Fun Games
// http://whilefun.com
//
public class FPEFindBrokenInteractions {

    private static string validPrefabExtension = ".prefab";
    private static string validInventoryItemPathEnd = "Resources/InventoryItems";
    private static string validPickupPathEnd = "Resources/Pickups";

    [MenuItem("While Fun Games/Find Broken Interactions", false, 201)]
    private static void NewMenuOption()
    {

        Debug.Log("FPEFindBrokenInteractions:: Finding Broken Interactions...");
        string errorString = FindInteractionIssues();

        if (errorString == "")
        {
            Debug.Log("FPEFindBrokenInteractions:: <color=green><b>PASS!</b></color>");
        }
        else
        {
            Debug.Log("FPEFindBrokenInteractions:: <color=red><b>FAIL!</b></color> Interaction Issues:\n\n" + errorString + "\n\n");
        }

    }

    public static string FindInteractionIssues()
    {

        string result = "";

        //
        // Inventory Items
        //
        FPEInteractablePickupScript[] allInventoryItems = GameObject.FindObjectsOfType<FPEInteractableInventoryItemScript>();

        Object tempObject = null;

        foreach (FPEInteractablePickupScript inv in allInventoryItems)
        {

            tempObject = PrefabUtility.GetPrefabParent(inv.gameObject);

            if (tempObject == null)
            {
                result += "No prefab exists for object '" + inv.gameObject.name + "'\n";
            }
            else
            {

                string prefabPath = AssetDatabase.GetAssetPath(tempObject);

                // Does it end in '.prefab'?
                string ext = prefabPath.Substring(prefabPath.Length - 7, 7);

                if (ext != validPrefabExtension)
                {
                    result += "Object '" + inv.gameObject.name + "' is NOT a prefab!" + "\n";
                }

                // Does it live in *\Resources\InventoryItems\?
                string[] pathChunks = prefabPath.Split('/');
                string pathEnd = pathChunks[pathChunks.Length - 3] + "/" + pathChunks[pathChunks.Length - 2];

                if (pathEnd != validInventoryItemPathEnd)
                {
                    result += "Object '" + inv.gameObject.name + "' is not in a '" + validInventoryItemPathEnd + "' folder!" + "\n";
                }

            }

        }


        //
        // Pickups
        //

        FPEInteractablePickupScript[] allPickups = GameObject.FindObjectsOfType<FPEInteractablePickupScript>();

        tempObject = null;
        
        foreach (FPEInteractablePickupScript pu in allPickups)
        {

            tempObject = PrefabUtility.GetPrefabParent(pu.gameObject);

            if(tempObject == null)
            {
                result += "No prefab exists for object '" + pu.gameObject.name + "'\n";
            }
            // We also want to exclude Inventory Items since we already checked those, and they are technically also Pickups but live in a different folder.
            else if(pu.gameObject.GetComponent<FPEInteractableInventoryItemScript>() == null)
            {

                string prefabPath = AssetDatabase.GetAssetPath(tempObject);

                // Does it end in '.prefab'?
                string ext = prefabPath.Substring(prefabPath.Length - 7, 7);

                if(ext != validPrefabExtension)
                {
                    result += "Object '" + pu.gameObject.name + "' is NOT a prefab!" + "\n";
                }

                // Does it live in *\Resources\Pickups\?
                string[] pathChunks = prefabPath.Split('/');
                string pathEnd = pathChunks[pathChunks.Length - 3] + "/" + pathChunks[pathChunks.Length - 2];

                if (pathEnd != validPickupPathEnd)
                {
                    result += "Object '" + pu.gameObject.name + "' is not in a '" + validPickupPathEnd + "' folder!" + "\n";
                }

            }

        }

        //
        // TODO: Other interaction types
        //

        return result;

    }

}
