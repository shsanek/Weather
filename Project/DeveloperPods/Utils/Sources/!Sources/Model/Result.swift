//
//  Result.swift
//  WeatherUserStory
//
//  Created by Alex Shipin on 11.08.2020.
//

public enum Result<ObjectType, ErrorType>
{
    case success(data: ObjectType)
    case failure(error: ErrorType)
}
